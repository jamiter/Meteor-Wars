gridItemSize = 80
selectedUnitIdName = 'selectedUnitId'
targetedUnitIdName = 'targetedUnitId'

getAngleBetweenPoints = (a, b) ->
  Math.atan2(a[1] - b[1], a[0] - b[0]) * 180 / Math.PI;

walkPath = (path, xVar, yVar, angleVar) ->
  createWaitPromite = (i) ->
    point = path[i]

    if not point
      new Promise (resolve) -> resolve()
    else
      new Promise (resolve, reject) ->
        timeout = if i is 0 then 0 else 200

        update =
          x: point[0]
          y: point[1]

        if previousPoint = path[i-1]
          update.angle = getAngleBetweenPoints point, previousPoint

        Meteor.setTimeout ->
          xVar.set update.x
          yVar.set update.y
          if update.angle?
            angleVar.set update.angle

          createWaitPromite(i+1).then resolve
        , timeout

  createWaitPromite(0)

Template.Unit.onCreated ->
  @currentX = new ReactiveVar @data.unit.x
  @currentY = new ReactiveVar @data.unit.y
  @currentAngle = new ReactiveVar(@data.unit.angle or 0)

  @moving = new ReactiveVar false

  @autorun =>
    unit = Units.findOne @data.unit._id

    Tracker.nonreactive =>
      if unit.angle isnt @currentAngle
        @currentAngle.set unit.angle

    Tracker.nonreactive =>
      if unit.x isnt @currentX.get() or unit.y isnt @currentY.get()
        @moving.set true

        path = unit.getPathToPoint @data.grid,
          x: @currentX.get()
          y: @currentY.get()
        ,
          reverse: true

        if path.length
          walkPath path, @currentX, @currentY, @currentAngle
          .then =>
            @moving.set false

Template.Unit.helpers
  unitStyle: ->
    "left: #{Template.instance().currentX.get() * gridItemSize}px;
    top: #{Template.instance().currentY.get() * gridItemSize}px;"

  imageStyle: ->
    # The extra 90 is to compensate for the fact that the images are pointing
    # north, instead of east (which would be 0 degrees)
    "transform: rotate(#{90 + Template.instance().currentAngle.get()}deg);"

  unitTemplate: ->
    @unit.templateName

  unitData: ->
    teamColor: @unit.getTeamColor()
    strokeTeamColor: tinycolor(@unit.getTeamColor()).darken(30).toString()

  className: ->
    tpl = Template.instance()

    classes = [@unit.type]

    if @unit._id is Session.get selectedUnitIdName
      classes.push 'selected'

    if @unit._id is Session.get targetedUnitIdName
      classes.push 'targeted'

    if (not tpl.moving.get()) and @unit.canDoAction() and (not @unit.canMove())
      classes.push 'moved'

    classes.join ' '

  selected: ->
    @unit._id is Session.get selectedUnitIdName

  canAttack: ->
    @unit.findTargets()?.count()

  healthBarWidth: ->
    Math.ceil(@unit.getStrengthDamageModifier() * 100)

Template.Unit.events
  'click .unit': ->
    if @unit._id isnt Session.get targetedUnitIdName
      if @unit._id is Session.get selectedUnitIdName
        Session.set selectedUnitIdName, null
      else
        if @unit.findRound()?.getCurrentPlayer()._id isnt @unit.playerId
          Session.set selectedUnitIdName, null
        else
          Session.set selectedUnitIdName, @unit._id

      Session.set targetedUnitIdName, null
    else if attacker = Units.findOne Session.get selectedUnitIdName
      Session.set targetedUnitIdName, null

      attacker.attack @unit

  'mouseover .unit': ->
    return unless selectedUnitId = Session.get selectedUnitIdName
    return if selectedUnitId is @unit._id
    return unless attacker = Units.findOne selectedUnitId

    if attacker.canTarget @unit
      Session.set targetedUnitIdName, @unit._id
