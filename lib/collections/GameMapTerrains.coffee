@GameMapTerrains = new Mongo.Collection 'gamemapterrains',
  transform: (data) ->
    new GameMapTerrain data

GameMapTerrainSchema = new SimpleSchema
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
  gameId:
    type: String
  gameMapId:
    type: String
  terrainTypeId:
    type: String
  loc:
    type: [Number]
  angle:
    type: Number

GameMapTerrains.attachSchema GameMapTerrainSchema

class @GameMapTerrain extends Model

  @_collection: GameMapTerrains

  getType: ->
    TerrainTypes.findOne @terrainTypeId
