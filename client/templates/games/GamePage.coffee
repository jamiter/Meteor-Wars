Template.GamePage.onCreated ->
  @autorun =>
    if gameId = FlowRouter.getParam 'gameId'
      @subscribe 'players', gameId: gameId

Template.GamePage.helpers
  game: ->
    gameId = FlowRouter.getParam 'gameId'

    Games.findOne _id: gameId

  pendingRounds: ->
    gameId = FlowRouter.getParam 'gameId'

    options =
      sort:
        createdAt: -1
        finishedAt: 1
        startedAt: 1

    Rounds.find
      gameId: gameId
      finishedAt: null
      startedAt: null
    ,
      options

  activeRounds: ->
    gameId = FlowRouter.getParam 'gameId'

    options =
      sort:
        createdAt: -1
        finishedAt: 1
        startedAt: 1

    Rounds.find
      gameId: gameId
      finishedAt: null
      startedAt: $ne: null
    ,
      options

  finishedRounds: ->
    gameId = FlowRouter.getParam 'gameId'

    options =
      sort:
        finishedAt: 1
        startedAt: 1

    Rounds.find
      gameId: gameId
      finishedAt: $ne: null
    ,
      options

  countPlayers: ->
    Players.find(
      gameId: @_id
      userId: $ne: null
    ).count()
