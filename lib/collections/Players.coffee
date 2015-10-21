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

  isMe: ->
    if not Meteor.isClient
      throw new Error "#isMe can only be called on the client"

    @userId and @userId is Meteor.userId()

  findRound: ->
    Rounds.findOne @roundId

  isCurrentPlayer: ->
    @_id is @findRound()?.getCurrentPlayer()?._id

  getDayNumber: ->
    Turns.find
      roundId: @roundId
      playerId: @_id
    .count()

  getTeamColor: ->
    if @color
      @color
    else
      switch @rank
        when 1
          "#48C8F8"
        when 2
          "#F00008"
        when 3
          "#FF0"
        else
          "#999"

  runAi: ->
    round = @findRound()

    units = (Units.find
      playerId: @_id
      roundId: @roundId
      moved: null
    ).fetch()

    createUnitAiPromise = (i) ->
      unit = units[i]

      if not unit
        new Promise (resolve) -> resolve()
      else
        unit.runAi().then ->
          createUnitAiPromise(i+1)

    createUnitAiPromise(0).then ->
      round.nextTurn()
