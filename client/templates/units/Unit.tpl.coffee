gridItemSize = 50

Template.Unit.helpers
  unitStyle: ->
    "left: #{@x * gridItemSize}px;
    top: #{@y * gridItemSize}px;"

  className: ->
    classes = [@type]

    if @_id is Session.get 'selectedUnitId'
      classes.push 'selected'

    if @hasMoved
      classes.push 'moved'

    classes.join ' '

Template.Unit.events
  'click': ->
    Session.set 'selectedUnitId', @_id
