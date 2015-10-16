tileSize = 80
selectedUnitIdName = 'selectedUnitId'
targetedUnitIdName = 'targetedUnitId'

getAngleBetweenPoints = (a, b) ->
  Math.atan2(a[1] - b[1], a[0] - b[0]) * 180 / Math.PI;

walkPath = (path, locVar, angleVar) ->
  createWaitPromite = (i) ->
    point = path[i]

    if not point
      new Promise (resolve) -> resolve()
    else
      new Promise (resolve, reject) ->
        timeout = if i is 0 then 0 else 200

        Meteor.setTimeout ->
          locVar.set point

          if previousPoint = path[i-1]
            angle = getAngleBetweenPoints point, previousPoint
            angleVar.set angle

          createWaitPromite(i+1).then resolve
        , timeout

  createWaitPromite(0)

Template.Unit.onCreated ->
  @currentLocation = new ReactiveVar @data.unit.loc or [0,0]
  @currentAngle = new ReactiveVar(@data.unit.angle or 0)

  @moving = new ReactiveVar false

  @autorun =>
    unit = Units.findOne @data.unit._id

    Tracker.nonreactive =>
      if unit.angle isnt @currentAngle
        @currentAngle.set unit.angle

    Tracker.nonreactive =>
      if unit.loc?.toString() isnt @currentLocation.get().toString()
        @moving.set true

        path = unit.getPathToPoint @data.grid, @currentLocation.get(),
          reverse: true

        if path.length
          walkPath path, @currentLocation, @currentAngle
          .then =>
            @moving.set false

Template.Unit.onDestroyed ->
  location = @currentLocation.get()

  Blaze.renderWithData Template.Explosion, {loc: location}, $('.map')[0]

Template.Unit.helpers
  unitStyle: ->
    "left: #{Template.instance().currentLocation.get()[0] * tileSize}px;
    top: #{Template.instance().currentLocation.get()[1] * tileSize}px;"

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
    @unit.findTargetUnits()?.count()

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
