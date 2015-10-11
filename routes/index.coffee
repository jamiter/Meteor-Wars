FlowRouter.route '/',
  action: ->
    BlazeLayout.render 'SettingsLayout', main: 'GameOverview'

FlowRouter.route '/games/:gameId',
  action: ->
    BlazeLayout.render 'SettingsLayout', main: 'GamePage'

FlowRouter.route '/games/:gameId/rounds/:roundId',
  action: ->
    BlazeLayout.render 'SettingsLayout', main: 'RoundSettings'

FlowRouter.route '/games/:gameId/rounds/:roundId/play',
  action: ->
    BlazeLayout.render 'GameLayout', main: 'GameTable'
