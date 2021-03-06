findRound = ->
  roundId = FlowRouter.getParam 'roundId'
  Rounds.findOne roundId

Template.RoundMap.onCreated ->
  @path = new ReactiveVar []

  @autorun =>
    if round = findRound()
      if map = round.findMap()
        @grid = new PF.Grid(map.dimensions[0],map.dimensions[1])

  @autorun =>
    unitId = Session.get 'selectedUnitId'

    return unless @grid

    if not unitId
      @path.set []
      Session.set 'reachableTiles', {}
    else
      unit = Units.findOne unitId

      return unless unit

      tiles = unit.getReachableTiles @grid, indexed: true

      Session.set 'reachableTiles', tiles

  @autorun =>
    return unless Meteor.userId()
    return unless gameId = FlowRouter.getParam('gameId')
    return unless roundId = FlowRouter.getParam('roundId')

    @subscribe 'games', _id: gameId
    @subscribe 'gamemaps', gameId: gameId
    @subscribe 'unittypes', gameId: gameId
    @subscribe 'rounds', _id: roundId
    @subscribe 'players', roundId: roundId
    @subscribe 'units', roundId: roundId
    @subscribe 'terrains', roundId: roundId
    @subscribe 'turns', roundId: roundId

Template.RoundMap.onRendered ->
  @$('.modal-trigger').leanModal()

  currentPlayerId = null

  @autorun =>
    if @subscriptionsReady()
      if (round = findRound()) and not round.hasFinished()
        if player = round.getCurrentPlayer()
          if player._id isnt currentPlayerId
            currentPlayerId = player._id
            Blaze.renderWithData Template.PlayerTurnAlert, player, document.body

Template.RoundMap.helpers
  mapStyle: ->
    grid = Template.instance().grid

    "width: #{grid.width * gridTileSize}px;
    height: #{grid.height * gridTileSize}px"

  round: ->
    findRound()

  players: ->
    return unless roundId = FlowRouter.getParam 'roundId'

    Players.find roundId: roundId

  units: ->
    return unless roundId = FlowRouter.getParam 'roundId'

    Units.find roundId: roundId

  terrains: ->
    return unless roundId = FlowRouter.getParam 'roundId'

    Terrains.find roundId: roundId

  hasFinished: ->
    findRound()?.hasFinished()

  grid: ->
    Template.instance().grid

  tiles: ->
    Template.instance().grid.nodes

  path: ->
    Template.instance().path.get()

  gridClass: ->
    classes = []

    path = Template.instance().path.get()

    for point in path
      if (@x is point[0]) and (@y is point[1])
        classes.push 'path'
        break

    if tiles = Session.get 'reachableTiles'
      if tiles["#{@x}:#{@y}"]
        classes.push 'reachable'

    classes.join ' '

  isCurrentPlayer: ->
    @getCurrentPlayer().userId is Meteor.userId()

Template.RoundMap.events
  'click .modal-trigger': (e) ->
    Template.instance().$('#surrenderModal').openModal()

  'click #surrenderBtn': ->
    roundId = FlowRouter.getParam 'roundId'

    Meteor.call 'round/surrender', roundId

  'click .next-turn': ->
    @nextTurn()

  'mouseover .tile.reachable': ->
    return unless unitId = Session.get 'selectedUnitId'
    return unless roundId = FlowRouter.getParam 'roundId'

    unit = Units.findOne unitId

    return unless unit?.canMove()

    point = [@x, @y]

    path = unit.getPathToPoint Template.instance().grid, point

    if path.cost > (unit.moverange)
      Template.instance().path.set []
    else
      Template.instance().path.set path

  'click .tile.reachable': ->
    return unless unitId = Session.get 'selectedUnitId'
    return unless unit = Units.findOne unitId

    path = Template.instance().path

    if unit.moveToEndOfPath path.get()
      path.set []
