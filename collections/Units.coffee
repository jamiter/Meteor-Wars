@Units = new Mongo.Collection 'units',
  transform: (data) ->
    new Unit data

UnitSchema = new SimpleSchema
  unitTypeId:
    type: String
  roundId:
    type: String
  abilities:
    type: [String]
    optional: true
  rank:
    type: Number

# Units.attachSchema UnitSchema

class Unit extends Model

  @_collection: Units

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
    return false if unit.playerId is @playerId

    (unit.x is @x and unit.y >= @y-1 and unit.y <= @y+1) or
    (unit.y is @y and unit.x >= @x-1 and unit.x <= @x+1)

  attack: (unit = {}) ->
    return unless @canTarget unit

    unit.remove?()

  moveAlongPath: (path) ->
    return unless path.length > 1

    unit = this

    createWaitPromite = (i) ->
      point = path[i]

      if not point
        new Promise (resolve, reject) -> resolve()
      else
        new Promise (resolve, reject) ->
          timeout = if i is 0 then 0 else 200

          update =
            x: point[0]
            y: point[1]

          if previousPoint = path[i-1]
            if previousPoint[0] > point[0]
              update.angle = -90
            else if previousPoint[0] < point[0]
              update.angle = 90
            else if previousPoint[1] > point[1]
              update.angle = 0
            else if previousPoint[1] < point[1]
              update.angle = 180

          Meteor.setTimeout ->
            unit.set update

            createWaitPromite(i+1).then resolve
          , timeout

    createWaitPromite(0).then =>
      @set hasMoved: true
