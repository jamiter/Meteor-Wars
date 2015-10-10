FlowRouter.route '/',
  action: ->
    FlowLayout.render 'SettingsLayout', main: 'GameOverview'

FlowRouter.route '/games/:gameId',
  action: ->
    FlowLayout.render 'SettingsLayout', main: 'GamePage'

FlowRouter.route '/games/:gameId/rounds/:roundId',
  action: ->
    FlowLayout.render 'SettingsLayout', main: 'RoundSettings'

FlowRouter.route '/games/:gameId/rounds/:roundId/play',
  action: ->
    FlowLayout.render 'GameLayout', main: 'GameTable'
