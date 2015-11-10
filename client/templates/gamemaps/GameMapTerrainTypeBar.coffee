Template.GameMapTerrainTypeBar.onRendered ->
  @$('.terrain-type').draggable
    helper: 'clone'

Template.GameMapTerrainTypeBar.helpers
  types: ->
    TerrainTypes.find()
