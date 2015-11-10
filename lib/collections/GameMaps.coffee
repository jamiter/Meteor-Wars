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
  name:
    type: String
  minPlayers:
    type: Number
  maxPlayers:
    type: Number

GameMaps.attachSchema GameMapSchema

class GameMap extends Model

  @_collection: GameMaps

  getGrid: ->
    new PF.Grid(@dimensions[0],@dimensions[1])

  findTerrains: ->
    GameMapTerrains.find(gameMapId: @_id)

  findUnits: ->
    GameMapUnits.find(gameMapId: @_id)
