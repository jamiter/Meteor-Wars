gridItemSize = 80

Template.Immutable.helpers
  unitStyle: ->
    "left: #{@loc[0] * gridItemSize}px;
    top: #{@loc[1] * gridItemSize}px;"

  imageStyle: ->
    "transform: rotate(#{@angle or 0}deg);"
