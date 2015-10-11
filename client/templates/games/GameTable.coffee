finder = new PF.AStarFinder(allowDiagonal: false)
gridTileSize = 80

findRound = ->
  roundId = FlowRouter.getParam 'roundId'
  round = Rounds.findOne roundId

Template.GameTable.onCreated ->
  @path = new ReactiveVar []

  @autorun =>
    if round = findRound()
      @grid = new PF.Grid(round.mapMatrix[0],round.mapMatrix[1])

  @autorun =>
    if not Session.get 'selectedUnitId'
      @path.set []

  @autorun =>
    return unless Meteor.userId()
    return unless gameId = FlowRouter.getParam('gameId')
    return unless roundId = FlowRouter.getParam('roundId')

    @subscribe 'games', _id: gameId
    @subscribe 'rounds', _id: roundId
    @subscribe 'players', roundId: roundId
    @subscribe 'units', roundId: roundId
    @subscribe 'immutables', roundId: roundId

Template.GameTable.helpers
  mapStyle: ->
    grid = Template.instance().grid

    "width: #{grid.width * gridTileSize}px;
    height: #{grid.height * gridTileSize}px"

  round: ->
    findRound()

  players: ->
    roundId = FlowRouter.getParam 'roundId'

    Players.find roundId: roundId

  units: ->
    roundId = FlowRouter.getParam 'roundId'

    Units.find roundId: roundId

  immutables: ->
    roundId = FlowRouter.getParam 'roundId'

    Immutables.find roundId: roundId

  hasFinished: ->
    findRound()?.hasFinished()

  grid: ->
    Template.instance().grid.nodes

  path: ->
    Template.instance().path.get()

  gridClass: ->
    path = Template.instance().path.get()

    for point in path
      if (@x is point[0]) and (@y is point[1])
        return 'path'

  isCurrentPlayer: ->
    @getCurrentPlayer().userId is Meteor.userId()

Template.GameTable.events
  'click .add-unit': ->
    x = Math.floor Math.random() * @mapMatrix[0]
    y = Math.floor Math.random() * @mapMatrix[1]

    if not Units.findOne(x: x, y: y)
      @addUnit
        x: x
        y: y
        angle: Math.floor Math.random() * 360

  'click .next-turn': ->
    @nextTurn()

  'mouseover .grid-item': ->
    return unless unitId = Session.get 'selectedUnitId'
    return unless roundId = FlowRouter.getParam 'roundId'

    unit = Units.findOne unitId

    return unless unit?.canMove()

    units = Units.find
      roundId: roundId
      unitId: $ne: unitId

    walkGrid = Template.instance().grid.clone()

    units.forEach (unit) ->
      walkGrid.setWalkableAt unit.x, unit.y, false

    path = finder.findPath (unit.x or 0), (unit.y or 0), @x, @y, walkGrid

    if path.length > (unit.moverange or 5)
      Template.instance().path.set []
    else
      Template.instance().path.set path

  'click .grid-item': ->
    return unless unitId = Session.get 'selectedUnitId'

    unit = Units.findOne unitId

    path = Template.instance().path

    unit?.moveAlongPath(path.get())?.then -> path.set([])
