@Rounds = new Mongo.Collection 'rounds',
  transform: (data) ->
    new Round data

class Round extends Model

  @_collection: Rounds

  @MINIMUM_PLAYERS = 2
  @MAXIMUM_PLAYERS = 2

  @ERROR_NOT_ENOUGH_PLAYERS = "Not enought players to start the round"
  @ERROR_MAXIMUM_PLAYERS = "This round is already at its maximum of players"
  @ERROR_ALREADY_STARTED = "Users cannot be added after initialization of the round"
  @ERROR_ALREADY_FINISHED = "This round is already over"
  @ERROR_PLAYER_ALREADY_JOINED = "The player is already in this round"
  @ERROR_USER_ALREADY_JOINED = "The user is already in this round"

  name: ->
    @creatorName() + "'s game"

  creatorName: ->
    Players.findOne(
      roundId: @_id
      userId: @createdBy
    )?.name or 'unknown'

  finish: ->
    @update $set: finishedAt: new Date
    @hasFinished()

  getCurrentPlayer: ->
    if turn = @getCurrentTurn()
      turn.findPlayer()
    else
      @getNextPlayer()

  swapDir: ->
    @dir *= -1
    @update $set: dir: @dir

  _checkFinished: ->
    if @hasFinished() then throw new Error @constructor.ERROR_ALREADY_FINISHED

  getCurrentTurn: ->
    return if not @currentTurnId

    Turns.findOne @currentTurnId

  nextTurn: ->
    # This can only be done server side
    if Meteor.isClient
      return Meteor.call 'round/nextTurn', @_id

    @_checkFinished()

    if not @_checkWin()
      nextPlayer = @getNextPlayer()

      @getCurrentTurn()?.finish()

      @currentTurnId = Turns.insert
        roundId: @_id
        playerId: nextPlayer._id

      @update $set: currentTurnId: @currentTurnId

      turn = @getCurrentTurn()
      turn?.start()
      turn

  _checkWin: ->
    @_checkFinished()

    current = @getCurrentPlayer()

    if not current
      false
    else
      playerIds = @findUnits().fetch().reduce (playerIds, unit) ->
        if unit.playerId not in playerIds
          playerIds.push unit.playerId

        playerIds
      , []

      finished = playerIds.length is 1

      if finished
        @update $set: winnerId: playerIds[0]
        @finish()

      finished

  getNextPlayer: ->
    @_checkFinished()

    @dir ?= 1

    queryOptions = sort: rank: @dir

    findFirst = =>
      @findPlayer queryOptions

    if @countTurns() is 0
      findFirst()
    else
      turn = @getCurrentTurn()

      rank = turn.findPlayer().rank

      playerQuery =
        roundId: @_id
        rank: $gt: rank

      if @dir is -1
        playerQuery.rank = $lt: rank

      nextPlayer = Players.findOne playerQuery, queryOptions

      nextPlayer or findFirst()

  maxPlayersReached: ->
    @findPlayers().count() >= @findGame().maxPlayers

  canJoin: (userId) ->
    return false if @hasStarted()
    return false if @maxPlayersReached()

    # AI players have no userId
    return true if not userId

    player = Players.findOne
      userId: userId
      roundId: @_id

    not player

  addPlayer: (data = {}) ->
    if not @canJoin data.userId
      throw new Meteor.Error "CANT_JOIN"
      return

    defaultData =
      roundId: @_id
      gameId: @gameId

    if not data.name
      data.name = Meteor.users
        .findOne data.userId
        .username

    lastPlayer = @findPlayer
      sort: rank: -1

    lastRank = lastPlayer?.rank or 0

    data.rank = Math.ceil lastRank + 1

    mergedData = _.extend {}, data, defaultData

    Players.insert mergedData

  addUnit: (data = {}) ->
    if data.playerIndex?
      if player = @findPlayers($sort: rank: 1).fetch()[data.playerIndex]
        data.playerId = player._id

    delete data.playerIndex

    defaultData =
      roundId: @_id
      gameId: @gameId

    mergedData = _.extend {}, data, defaultData

    Units.insert mergedData

  start: ->
    round = this

    if not @canStart()
      throw new Meteor.Error "NO_PLAYERS_YET"
    else
      # TODO: randomize player rank

      @update $set: startedAt: Date.now()

      @nextTurn()

  canStart: (userId) ->
    if userId and @createdBy isnt userId
      return false

    @countPlayers() >= @findGame().maxPlayers

  findGame: ->
    Games.findOne @gameId

  hasStarted: ->
    Boolean @startedAt

  hasFinished: ->
    Boolean @finishedAt

  findPlayer: (options) ->
    Players.findOne roundId: @_id, options

  findPlayers: (options) ->
    Players.find roundId: @_id, options

  countPlayers: (options) ->
    @findPlayers(options).count()

  findTurns: (options) ->
    Turns.find roundId: @_id, options

  countTurns: (options) ->
    @findTurns(options).count()

  findUnits: (options) ->
    Units.find roundId: @_id, options

  countUnits: (options) ->
    @findUnits(options).count()

  winner: ->
    if @winnerId
      Players.findOne @winnerId
