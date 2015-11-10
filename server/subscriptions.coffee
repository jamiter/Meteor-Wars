Meteor.publish 'games', (query = {}) ->
  Games.find query

Meteor.publish 'gamemaps', (query = {}) ->
  return unless @userId

  query.$or = [
    createdBy: @userId
  ,
    createdBy: null
  ]

  GameMaps.find query

Meteor.publish 'gamemapunits', (query = {}) ->
  GameMapUnits.find query

Meteor.publish 'gamemapterrains', (query = {}) ->
  GameMapTerrains.find query

Meteor.publish 'rounds', (query = {}) ->
  Rounds.find query

Meteor.publish 'players', (query = {}) ->
  Players.find query

Meteor.publish 'turns', (query = {}) ->
  Turns.find query

Meteor.publish 'units', (query = {}) ->
  Units.find query

Meteor.publish 'unittypes', (query = {}) ->
  UnitTypes.find query

Meteor.publish 'terraintypes', (query = {}) ->
  TerrainTypes.find query

Meteor.publish 'terrains', (query = {}) ->
  Terrains.find query
