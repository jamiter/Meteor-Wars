@Games = new Mongo.Collection 'games',
  transform: (data) ->
    new Game data

GameSchema = new SimpleSchema
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
  name:
    type: String
  minPlayers:
    type: Number
  maxPlayers:
    type: Number
  maps:
    type: [Object]
    minCount: 1
    blackbox: true

Games.attachSchema GameSchema

class Game extends Model

  @_collection: Games

  findRounds: (options) ->
    Rounds.find gameId: @_id, options

  findPlayers: (options) ->
    Players.find gameId: @_id, options

  countPlayers: (options) ->
    @findPlayers(options).count()

  newRound: ->
    roundId = Rounds.insert
      gameId: @_id

    Rounds.findOne roundId
