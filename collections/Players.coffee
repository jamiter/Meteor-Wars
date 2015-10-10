@Players = new Mongo.Collection 'players',
  transform: (data) ->
    new Player data

class Player extends Model

  @_collection: Players

  init: ->

  isAi: ->
    not @userId

  isHuman: ->
    not @isAi()

  findRound: ->
    Rounds.findOne @roundId

  isCurrentPlayer: ->
    @_id is @findRound()?.getCurrentPlayer()?._id
