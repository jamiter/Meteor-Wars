gridItemSize = 50
selectedUnitIdName = 'selectedUnitId'
targetedUnitIdName = 'targetedUnitId'

Template.Unit.helpers
  unitStyle: ->
    "left: #{@x * gridItemSize}px;
    top: #{@y * gridItemSize}px;"

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

Template.Unit.events
  'click .unit': ->
    if @_id isnt Session.get targetedUnitIdName
      Session.set selectedUnitIdName, @_id
    else
      @remove()

  'mouseover .unit': ->
    return unless selectedUnitId = Session.get selectedUnitIdName
    return if selectedUnitId is @_id
    return unless attacker = Units.findOne selectedUnitId

    if attacker.canTarget this
      Session.set targetedUnitIdName, @_id
