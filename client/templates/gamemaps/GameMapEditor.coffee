Template.GameMapEditor.onCreated ->
  @autorun =>
    return unless gameId = FlowRouter.getParam('gameId')
    return unless gameMapId = FlowRouter.getParam('gameMapId')

    @subscribe('games', _id: gameId)
    @subscribe('gamemaps',
      _id: gameMapId
      gameId: gameId
    )

    @subscribe('gamemapunits',
      gameId: gameId
      gameMapId: gameMapId
    )

    @subscribe('gamemapterrains',
      gameId: gameId
      gameMapId: gameMapId
    )

    @subscribe 'unittypes', gameId: gameId
    @subscribe 'terraintypes', gameId: gameId

  if not FlowRouter.getQueryParam('playerIndex')
    FlowRouter.setQueryParams(playerIndex: '0')

Template.GameMapEditor.helpers
  map: ->
    if gameMapId = FlowRouter.getParam('gameMapId')
      GameMaps.findOne gameMapId

  players: ->
    [0...@minPlayers]

Template.GameMapEditor.events
  'click .add-player': ->
    @update $inc:
      minPlayers: 1
      maxPlayers: 1

  'change input:radio': (e) ->
    if playerIndex = $(e.currentTarget).val()
      FlowRouter.setQueryParams(playerIndex: playerIndex)
