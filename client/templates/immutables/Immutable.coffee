gridItemSize = 80

Template.Immutable.helpers
  unitStyle: ->
    "left: #{@x * gridItemSize}px;
    top: #{@y * gridItemSize}px;"

  imageStyle: ->
    "transform: rotate(#{@angle or 0}deg);"
