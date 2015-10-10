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

  findUnitType: (optons) ->
    UnitTypes.findOne @unitTypeId, options

  findTargets: ->
    return if @hasAttacked

    Units.find
      _id: $ne: @_id
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
    (unit.x is @x and unit.y >= @y-1 and unit.y <= @y+1) or
    (unit.y is @y and unit.x >= @x-1 and unit.x <= @x+1)
