tileSize = 80

Template.Explosion.onRendered ->
  Meteor.setTimeout =>
    $(@firstNode).remove()
  , 700

Template.Explosion.helpers
  style: ->
    "left: #{@loc[0] * tileSize}px; top: #{@loc[1] * tileSize}px;"
