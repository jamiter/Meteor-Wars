Meteor.methods
  'round/nextTurn': (roundId) ->
    check @userId, String
    check roundId, String

    return if Meteor.isClient
    return unless roundId
    return unless @userId

    return unless round = Rounds.findOne roundId
    return unless player = Players.findOne userId: @userId, roundId: roundId
    # return if player._id isnt round.getCurrentPlayer()._id

    round.nextTurn()

  'round/surrender': (roundId) ->
    check @userId, String
    check roundId, String

    player = Players.findOne
      roundId: roundId
      userId: @userId

    if player
      player.set surrenderedAt: new Date

      Units.remove playerId: player._id

  'round/add-ai': (roundId) ->
    check @userId, String
    check roundId, String

    round = Rounds.findOne
      _id: roundId
      createdBy: @userId

    unless round
      throw new Meteor.Error "NOT_ROUND_OWNER"

    aiPlayersCount = Players.find(
      roundId: roundId
      userId: null
    ).count()

    round.addPlayer
      name: "Computer #{aiPlayersCount + 1}"

  'round/start': (roundId) ->
    check @userId, String
    check roundId, String

    round = Rounds.findOne(_id: roundId)

    unitTypesMap = UnitTypes
    .find(
      gameId: round.gameId
    ,
      transform: false
    ).fetch().reduce (all, type) ->
        all[type._id] = type
        all
    , {}

    mapUnits = GameMapUnits.find
      gameMapId: round.gameMapId
    ,
      transform: false

    mapUnits.forEach (unit) ->
      type = unitTypesMap[unit.unitTypeId]

      defaultData =
        roundId: roundId
        health: type.maxHealth

      allData = _.extend defaultData, type, unit
      delete allData._id

      round.addUnit allData

    terrainTypesMap = TerrainTypes
    .find(
      gameId: round.gameId
    ,
      transform: false
    ).fetch().reduce (all, type) ->
      all[type._id] = type
      all
    , {}

    mapTerrains = GameMapTerrains.find
      gameMapId: round.gameMapId
    ,
      transform: false

    mapTerrains.forEach (terrain) ->
      type = terrainTypesMap[terrain.terrainTypeId]

      defaultData =
        roundId: roundId

      allData = _.extend defaultData, type, terrain
      delete allData._id

      round.addTerrain allData

    round.start()

