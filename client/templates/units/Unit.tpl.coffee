gridItemSize = 50
selectedUnitIdName = 'selectedUnitId'
targetedUnitIdName = 'targetedUnitId'

Template.Unit.helpers
  unitStyle: ->
    "left: #{@x * gridItemSize}px;
    top: #{@y * gridItemSize}px;
    transform: rotate(#{@angle or 0}deg);"

  className: ->
    classes = [@type]

    if @_id is Session.get selectedUnitIdName
      classes.push 'selected'

    if @_id is Session.get targetedUnitIdName
      classes.push 'targeted'

    if @hasMoved
      classes.push 'moved'

    classes.join ' '

  selected: ->
    @_id is Session.get selectedUnitIdName

  canAttack: ->
    @findTargets()?.count()

  strokeTeamColor: ->
    tinycolor(@getTeamColor()).darken(30).toString()

Template.Unit.events
  'click .unit': ->
    if @_id isnt Session.get targetedUnitIdName
      Session.set selectedUnitIdName, @_id
      Session.set targetedUnitIdName, null
    else if attacker = Units.findOne Session.get selectedUnitIdName
      attacker.attack this

  'mouseover .unit': ->
    return unless selectedUnitId = Session.get selectedUnitIdName
    return if selectedUnitId is @_id
    return unless attacker = Units.findOne selectedUnitId

    if attacker.canTarget this
      Session.set targetedUnitIdName, @_id
