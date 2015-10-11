finder = new PF.AStarFinder(allowDiagonal: false)
gridTileSize = 42
gridXSize = 25
gridYSize = 20
grid = new PF.Grid(gridXSize,gridYSize)

findRound = ->
  roundId = FlowRouter.getParam 'roundId'
  round = Rounds.findOne roundId

Template.GameTable.onCreated ->
  @path = new ReactiveVar []

Template.GameTable.helpers
  mapStyle: ->
    "width: #{gridXSize * gridTileSize}px;
    height: #{gridYSize * gridTileSize}px"

  round: ->
    findRound()

  players: ->
    roundId = FlowRouter.getParam 'roundId'

    Players.find roundId: roundId

  units: ->
    roundId = FlowRouter.getParam 'roundId'

    Units.find roundId: roundId

  hasFinished: ->
    findRound()?.hasFinished()

  grid: ->
    grid.nodes

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
    x = Math.floor Math.random() * gridXSize
    y = Math.floor Math.random() * gridYSize

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

    walkGrid = grid.clone()

    units.forEach (unit) ->
      walkGrid.setWalkableAt unit.x, unit.y, false

    path = finder.findPath (unit.x or 0), (unit.y or 0), @x, @y, walkGrid

    if path.length > (unit.move_range or 5)
      Template.instance().path.set []
    else
      Template.instance().path.set path

  'click .grid-item': ->
    return unless unitId = Session.get 'selectedUnitId'

    unit = Units.findOne unitId

    path = Template.instance().path

    unit.moveAlongPath(path.get())?.then -> path.set([])
