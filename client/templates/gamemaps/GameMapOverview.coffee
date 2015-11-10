Template.GameMapOverview.helpers
  maps: ->
    if gameId = FlowRouter.getParam('gameId')
      GameMaps.find(gameId: gameId)
