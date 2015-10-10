Template.GamePage.helpers
  game: ->
    gameId = FlowRouter.getParam 'gameId'

    Games.findOne _id: gameId

  activeRounds: ->
    gameId = FlowRouter.getParam 'gameId'

    options =
      sort:
        finishedAt: 1
        startedAt: 1

    Rounds.find
      gameId: gameId
      finishedAt: null
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
