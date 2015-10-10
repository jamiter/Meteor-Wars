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
  createdBy:
    type: String
  updatedBy:
    type: String
  # startedAt:
  #   type: Date
  #   optional: true
  # finishedAt:
  #   type: Date
  #   optional: true
  name:
    type: String

Games.attachSchema GameSchema

Games.before.insert (userId, doc) ->
  doc.createdBy ?= userId
  doc.updatedBy ?= userId

Games.before.update (userId, doc) ->
  doc.updatedBy = userId

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
      # dir: 1

    Rounds.findOne roundId
