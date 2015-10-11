gridItemSize = 80
selectedUnitIdName = 'selectedUnitId'
targetedUnitIdName = 'targetedUnitId'

Template.Unit.helpers
  unitStyle: ->
    "left: #{@x * gridItemSize}px;
    top: #{@y * gridItemSize}px;"

  imageStyle: ->
    "transform: rotate(#{@angle or 0}deg);"

  unitTemplate: ->
    @templateName

  unitData: ->
    teamColor: @getTeamColor()
    strokeTeamColor: tinycolor(@getTeamColor()).darken(30).toString()

  className: ->
    classes = [@type]

    if @_id is Session.get selectedUnitIdName
      classes.push 'selected'

    if @_id is Session.get targetedUnitIdName
      classes.push 'targeted'

    if @canDoAction() and not @canMove()
      classes.push 'moved'

    classes.join ' '

  selected: ->
    @_id is Session.get selectedUnitIdName

  canAttack: ->
    @findTargets()?.count()

  healthBarWidth: ->
    Math.ceil(@getStrengthDamageModifier() * 100)

Template.Unit.events
  'click .unit': ->
    if @_id isnt Session.get targetedUnitIdName
      if @_id is Session.get selectedUnitIdName
        Session.set selectedUnitIdName, null
      else
        if @findRound()?.getCurrentPlayer()._id isnt @playerId
          Session.set selectedUnitIdName, null
        else
          Session.set selectedUnitIdName, @_id

      Session.set targetedUnitIdName, null
    else if attacker = Units.findOne Session.get selectedUnitIdName
      Session.set targetedUnitIdName, null
      attacker.attack this

  'mouseover .unit': ->
    return unless selectedUnitId = Session.get selectedUnitIdName
    return if selectedUnitId is @_id
    return unless attacker = Units.findOne selectedUnitId

    if attacker.canTarget this
      Session.set targetedUnitIdName, @_id
