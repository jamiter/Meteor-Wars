tileSize = 80

Template.Immutable.helpers
  unitStyle: ->
    "left: #{@loc[0] * tileSize}px;
    top: #{@loc[1] * tileSize}px;"

  imageStyle: ->
    "transform: rotate(#{@angle or 0}deg);"
