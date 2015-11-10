Template.SettingsLayout.onCreated ->
  @subscribe 'games'

  @autorun =>
    return unless Meteor.userId()
    return unless roundId = FlowRouter.getParam('roundId')

    @subscribe 'players', roundId: roundId

  @autorun =>
    return unless Meteor.userId()
    return unless gameId = FlowRouter.getParam('gameId')

    @subscribe 'rounds', gameId: gameId
    @subscribe 'gamemaps', gameId: gameId
