Template.GameMapUnit.onRendered ->
  @$('.unit-type').draggable(revert: "invalid")

Template.GameMapUnit.helpers
  unitStyle: ->
    "left: #{@unit.loc[0] * gridTileSize}px;
    top: #{@unit.loc[1] * gridTileSize}px;"

  imageStyle: ->
    # The extra 90 is to compensate for the fact that the images are pointing
    # north, instead of east (which would be 0 degrees)
    "transform: rotate(#{90 + @unit.angle}deg);"

  unitTemplate: ->
    @unit.getType().templateName

  unitData: ->
    teamColor: @unit.getTeamColor()
    strokeTeamColor: tinycolor(@unit.getTeamColor()).darken(30).toString()

Template.GameMapUnit.events
  'dblclick': ->
    if confirm('Remove this unit?')
      Template.instance().data.unit.remove()

  'click': ->
    unit = Template.instance().data.unit

    if unit.angle >= 270
      unit.set angle: 0
    else
      unit.update $inc: angle: 90
