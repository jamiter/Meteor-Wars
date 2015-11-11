@GameMaps = new Mongo.Collection 'gamemaps',
  transform: (data) ->
    new GameMap data

GameMapSchema = new SimpleSchema
  createdAt:
    type: Date
    autoValue: ->
      if @isInsert
        new Date
      else if @isUpsert
        $setOnInsert: new Date
  updatedAt:
    type: Date
    autoValue: ->
      if @isInsert or @isUpdate
        new Date
  createdBy:
    type: String
    optional: true
  gameId:
    type: String
  dimensions:
    type: [Number]
    max: 30
    min: 5
    maxCount: 2
    minCount: 2
  name:
    type: String
  minPlayers:
    type: Number
    min: 2
    max: 4
  maxPlayers:
    type: Number
    min: 2
    max: 4

GameMaps.attachSchema GameMapSchema

class GameMap extends Model

  @_collection: GameMaps

  getGrid: ->
    new PF.Grid(@dimensions[0],@dimensions[1])

  findTerrains: ->
    GameMapTerrains.find(gameMapId: @_id)

  findUnits: ->
    GameMapUnits.find(gameMapId: @_id)
