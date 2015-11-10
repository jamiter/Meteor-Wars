@GameMapUnits = new Mongo.Collection 'gamemapunits',
  transform: (data) ->
    new GameMapUnit data

GameMapUnitSchema = new SimpleSchema
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
  unitTypeId:
    type: String
  playerIndex:
    type: Number
  loc:
    type: [Number]
  angle:
    type: Number

GameMapUnits.attachSchema GameMapUnitSchema

class @GameMapUnit extends Model

  @_collection: GameMapUnits

  getType: ->
    UnitTypes.findOne @unitTypeId

  getTeamColor: ->
    switch @playerIndex
      when 0
        "#48C8F8"
      when 1
        "#F00008"
      when 2
        "#FF0"
      else
        "#999"
