finder = new PF.AStarFinder(allowDiagonal: false)

@Units = new Mongo.Collection 'units',
  transform: (data) ->
    new Unit data

UnitSchema = new SimpleSchema
  roundId:
    type: String
  x:
    type: Number
  y:
    type: Number
  angle:
    type: Number
    min: 0
    max: 360
  name:
    type: String
  type:
    type: String
  image:
    type: String
  health:
    type: Number
  minShootingrange:
    type: Number
  maxShootingrange:
    type: Number
  moverange:
    type: Number
  damage:
    type: Object
    blackbox: true
  moved:
    type: Boolean
    optional: true
  attacked:
    type: Boolean
    optional: true

@Units.after.remove (userId, doc) ->
  unit = new Unit doc
  unit.findRound()?._checkWin()

# Units.attachSchema UnitSchema

class Unit extends Model

  @_collection: Units

  getMaxHealth: ->
    @maxHealth or 100

  getHealth: ->
    @health ?= 100

  atMaxHealth: ->
    @getHealth() >= @getMaxHealth()

  getMaxStrength: ->
    @maxStrength or 10

  atMaxStrength: ->
    @getMaxStrength() is @getStrength()

  getDamage: (unit) ->
    return 0 if not dmg = @damage?[unit.type]

    Math.ceil @getStrengthDamageModifier() * (dmg + (0.8 + Math.random() * 0.4))

  getStrength: ->
    health = @getHealth()

    if not health
      0
    else
      Math.ceil (health / @getMaxHealth()) * @getMaxStrength()

  getStrengthDamageModifier: ->
    (@getStrength() / @getMaxStrength())

  getTeamColor: ->
    @findPlayer().getTeamColor()

  findRound: ->
    Rounds.findOne @roundId

  findPlayer: ->
    Players.findOne @playerId

  ownedByCurrentPlayer: ->
    @playerId is @findRound().getCurrentPlayer()._id

  findUnitType: (optons) ->
    UnitTypes.findOne @unitTypeId, options

  findTargets: ->
    return if @hasAttacked

    Units.find
      _id: $ne: @_id
      playerId: $ne: @playerId
      $or: [
        y: @y
        $and: [
          x: $lte: @x + 1
        ,
          x: $gte: @x - 1
        ]
      ,
        x: @x
        $and: [
          y: $lte: @y + 1
        ,
          y: $gte: @y - 1
        ]
      ]

  canTarget: (unit = {}) ->
    return false if not @canAttack()
    return false if unit.playerId is @playerId
    return false if not @getDamage unit

    (unit.x is @x and unit.y >= @y-1 and unit.y <= @y+1) or
    (unit.y is @y and unit.x >= @x-1 and unit.x <= @x+1)

  canMove: ->
    not @moved and not @hasAttacked and @canDoAction()

  canAttack: ->
    not @attacked and @canDoAction()

  getAngleToPoint: (point) ->
    Math.atan2(point.y - @y, point.x - @x) * 180 / Math.PI;

  attack: (unit = {}) ->
    return unless @canTarget unit

    @set
      attacked: true
      angle: @getAngleToPoint unit

    unit.set
      angle: unit.getAngleToPoint this

    unit.takeDamage @getDamage(unit)

    if unit.health >= 0
      @takeDamage unit.getDamage this

  takeDamage: (damage) ->
    health = Math.max(0, @getHealth() - damage)

    if health is 0
      @remove()
    else
      @set health: health

  canDoAction: ->
    player = @findPlayer()

    return false unless player.isCurrentPlayer()

    (not Meteor.isClient) or player.userId is Meteor.userId()

  getReachableTiles: (grid, options = {}) ->
    tiles = []
    indexedTiles = {}

    if not @canMove()
      # Do nothing
    else if not @moverange or @moverange < 1
      # Do nothing
    else
      leftX = Math.max 0, @x - @moverange
      topY = Math.max 0, @y - @moverange
      rightX = Math.min grid.width - 1, @x + @moverange
      bottomY = Math.min grid.height - 1, @y + @moverange

      units = Units.find
        roundId: @roundId
        unitId: $ne: @_id

      walkGrid = grid.clone()

      units.forEach (unit) ->
        walkGrid.setWalkableAt unit.x, unit.y, false

      for x in [leftX..rightX]
        for y in [topY..bottomY]
          # Do mark the units position as walkable
          continue if x is @x and y is @y

          path = finder.findPath @x, @y, x, y, walkGrid.clone()

          if path.length and path.length <= @moverange
            if options.indexed
              indexedTiles["#{x}:#{y}"] = 1
            else
              tiles.push [x,y]

    if options.indexed
      indexedTiles
    else
      tiles

  getTargetQuery: ->
    query =
      _id: $ne: @_id
      playerId: $ne: @playerId
      roundId: @roundId
      $or: [
        x: @x
        $and: [
          y: $gte: @y-1
        ,
          y: $lte: @y+1
        ]
      ,
        y: @y
        $and: [
          x: $gte: @x-1
        ,
          x: $lte: @x+1
        ]
      ]

  getTargets: ->
    query = @getTargetQuery()

    options =
      $sort: health: 1

    Units.find query, options

  getSingleTarget: ->
    query = @getTargetQuery()

    options =
      $sort: health: 1

    Units.findOne query, options

  getBlockingPoints: ->
    Units.find
      roundId: @roundId
      _id: $ne: @_id

  getPathToPoint: (grid, point, options = {}) ->
    blockingPoints = @getBlockingPoints()

    walkGrid = grid.clone()

    blockingPoints.forEach (point) ->
      walkGrid.setWalkableAt point.x, point.y, false

    if options.reverse
      finder.findPath point.x, point.y, @x, @y, walkGrid
    else
      finder.findPath @x, @y, point.x, point.y, walkGrid

  setToEndOfPath: (path = []) ->
    return unless @canMove()
    return unless path.length

    point = path[path.length-1]

    @set
      x: point[0]
      y: point[1]
      moved: true

  runAi: ->
    round = @findRound()

    if target = @getSingleTarget()
      @attack target

    grid = new PF.Grid(round.mapMatrix[0],round.mapMatrix[1])

    tiles = @getReachableTiles grid

    index = Math.floor Math.random() * tiles.length

    targetTile = tiles[index]

    if targetTile
      path = @getPathToPoint grid,
        x: targetTile[0]
        y: targetTile[1]
    else
      path = []

    @setToEndOfPath path

    new Promise (resolve) =>
      Meteor.setTimeout =>
        if not target and target = @getSingleTarget()
          @attack target

        resolve()

      , 1000
