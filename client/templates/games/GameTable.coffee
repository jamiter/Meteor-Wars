finder = new PF.AStarFinder(allowDiagonal: false)
grid = new PF.Grid(10,10)

Template.GameTable.onCreated ->
  @path = new ReactiveVar []

Template.GameTable.helpers
  round: ->
    roundId = FlowRouter.getParam 'roundId'

    Rounds.findOne roundId

  players: ->
    roundId = FlowRouter.getParam 'roundId'

    Players.find roundId: roundId

  units: ->
    roundId = FlowRouter.getParam 'roundId'

    Units.find roundId: roundId

  hasFinished: ->
    roundId = FlowRouter.getParam 'roundId'

    round = Rounds.findOne roundId

    round?.hasFinished()

  grid: ->
    grid.nodes

  path: ->
    Template.instance().path.get()

  gridClass: ->
    path = Template.instance().path.get()

    for point in path
      if (@x is point[0]) and (@y is point[1])
        return 'path'

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

    path = Template.instance().path
    points = path.get()

    return unless points.length > 1

    unit = Units.findOne unitId

    return unless unit

    unit.set hasMoved: true

    createWaitPromite = (i) ->
      point = points[i]

      if not point
        new Promise (resolve, reject) -> resolve()
      else
        new Promise (resolve, reject) ->
          timeout = if i is 0 then 0 else 200

          Meteor.setTimeout ->
            unit.set
              x: point[0]
              y: point[1]

            createWaitPromite(i+1).then resolve
          , timeout

    createWaitPromite(0).then ->
      path.set([])
