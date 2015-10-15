finder = new PF.AStarFinder(allowDiagonal: false)

@Units = new Mongo.Collection 'units',
  transform: (data) ->
    new Unit data

UnitSchema = new SimpleSchema
  gameId:
    type: String
  playerId:
    type: String
  roundId:
    type: String
  angle:
    type: Number
    min: -360
    max: 360
  name:
    type: String
  type:
    type: String
  maxHealth:
    type: Number
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
  loc:
    type: [Number]
    index: '2d'
  templateName:
    type: String

@Units.after.remove (userId, doc) ->
  unit = new Unit doc
  unit.findRound()?._checkWin()

Units.attachSchema UnitSchema

getDistanceBetweenPoints = (a, b) ->
  Math.sqrt( Math.pow((a[0]-b[0]), 2) + Math.pow((a[1]-b[1]), 2) )

class Unit extends Model

  @_collection: Units

  getMaxHealth: ->
    @maxHealth or 100

  getHealth: ->
    @health ?= 100

  atMaxHealth: ->
    @getHealth() >= @getMaxHealth()

  getMaxStrength: ->
    10

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

  findTargetUnits: ->
    return if @hasAttacked

    query = @getTargetQuery()

    options =
      $sort: health: 1

    Units.find query, options

  getTargetQuery: ->
    query =
      _id: $ne: @_id
      playerId: $ne: @playerId
      roundId: @roundId
      loc:
        $near: @loc
        $maxDistance: 1

  findSingleTargetUnit: ->
    query = @getTargetQuery()

    options =
      $sort: health: 1

    Units.findOne query, options

  canTarget: (unit = {}) ->
    return false if not @canAttack()
    return false if unit.playerId is @playerId
    return false if not @getDamage unit

    (unit.loc[0] is @loc[0] and unit.loc[1] >= @loc[1]-1 and unit.loc[1] <= @loc[1]+1) or
    (unit.loc[1] is @loc[1] and unit.loc[0] >= @loc[0]-1 and unit.loc[0] <= @loc[0]+1)

  canMove: ->
    not @moved and not @hasAttacked and @canDoAction()

  canAttack: ->
    not @attacked and @canDoAction()

  getAngleToPoint: (point) ->
    Math.atan2(point[1] - @loc[1], point[0] - @loc[0]) * 180 / Math.PI

  attack: (unit = {}) ->
    return unless @canTarget unit

    @set
      attacked: true
      angle: @getAngleToPoint unit.loc

    unit.set
      angle: unit.getAngleToPoint @loc

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
      leftX = Math.max 0, @loc[0] - @moverange
      topY = Math.max 0, @loc[1] - @moverange
      rightX = Math.min grid.width - 1, @loc[0] + @moverange
      bottomY = Math.min grid.height - 1, @loc[1] + @moverange

      units = Units.find
        roundId: @roundId
        unitId: $ne: @_id

      walkGrid = grid.clone()

      units.forEach (unit) ->
        walkGrid.setWalkableAt unit.loc[0], unit.loc[1], false

      for x in [leftX..rightX]
        for y in [topY..bottomY]
          # Don't mark the units position as walkable
          continue if x is @loc[0] and y is @loc[1]

          path = finder.findPath @loc[0], @loc[1], x, y, walkGrid.clone()

          if path.length and path.length <= (@moverange + 1)
            if options.indexed
              indexedTiles["#{x}:#{y}"] = 1
            else
              tiles.push [x,y]

    if options.indexed
      indexedTiles
    else
      tiles

  getBlockingUnits: ->
    Units.find
      roundId: @roundId
      _id: $ne: @_id

  getPathToPoint: (grid, point, options = {}) ->
    blockingUnits = @getBlockingUnits()

    walkGrid = grid.clone()

    blockingUnits.forEach (unit) ->
      walkGrid.setWalkableAt unit.loc[0], unit.loc[1], false

    if options.reverse
      finder.findPath point[0], point[1], @loc[0], @loc[1], walkGrid
    else
      finder.findPath @loc[0], @loc[1], point[0], point[1], walkGrid

  moveToEndOfPath: (path = []) ->
    return unless @canMove()
    return unless path.length

    point = path[path.length-1]

    @set
      loc: point
      moved: true

  runAi: ->
    round = @findRound()

    if target = @findSingleTargetUnit()
      @attack target
    else
      query = @getTargetQuery()
      query.loc.$maxDistance = @moverange + 1

      options =
        fields: loc: 1
        $sort: health: 1

      closestLocation = Units.find(query, options).fetch()[0]?.loc

    grid = new PF.Grid(round.mapMatrix[0],round.mapMatrix[1])

    tiles = @getReachableTiles grid

    if not closestLocation
      # Super intellegence: No enemy close? Move randomly!
      index = Math.floor Math.random() * tiles.length
    else
      tiles.some (tile, i) ->
        if 1 >= getDistanceBetweenPoints tile, closestLocation
          index = i

    targetTile = tiles[index]

    if targetTile
      path = @getPathToPoint grid, targetTile
    else
      path = []

    @moveToEndOfPath path

    new Promise (resolve) =>
      Meteor.setTimeout =>
        if not target and target = @findSingleTargetUnit()
          @attack target

        resolve()

      , 1000
