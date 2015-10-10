finder = new PF.AStarFinder(allowDiagonal: false)
grid = new PF.Grid(10,10)

findRound = ->
  roundId = FlowRouter.getParam 'roundId'
  round = Rounds.findOne roundId

Template.GameTable.onCreated ->
  @path = new ReactiveVar []

Template.GameTable.helpers
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
    @addUnit
      x: 0
      y: 0

  'click .next-turn': ->
    @nextTurn()

  'mouseover .grid-item': ->
    return unless unitId = Session.get 'selectedUnitId'
    return unless roundId = FlowRouter.getParam 'roundId'

    unit = Units.findOne unitId

    return unless unit
    return if unit.hasMoved
    return unless findRound().getCurrentPlayer().userId is Meteor.userId()

    units = Units.find
      roundId: roundId
      unitId: $ne: unitId

    walkGrid = grid.clone()

    units.forEach (unit) ->
      walkGrid.setWalkableAt unit.x, unit.y, false

    path = finder.findPath (unit.x or 0), (unit.y or 0), @x, @y, walkGrid

    if path.length > unit.move_range
      Template.instance().path.set []
    else
      Template.instance().path.set path

  'click .grid-item': ->
    return unless unitId = Session.get 'selectedUnitId'
    return unless findRound().getCurrentPlayer().userId is Meteor.userId()

    unit = Units.findOne unitId

    return unless unit

    path = Template.instance().path

    unit.moveAlongPath(path.get())?.then -> path.set([])
