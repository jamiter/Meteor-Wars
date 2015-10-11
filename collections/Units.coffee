@Units = new Mongo.Collection 'units',
  transform: (data) ->
    new Unit data

UnitSchema = new SimpleSchema
  roundId:
    type: String
  mapMatrixPosition:
    type: [Number]
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


# Units.attachSchema UnitSchema

class Unit extends Model

  @_collection: Units

  findUnitType: (optons) ->
    UnitTypes.findOne @unitTypeId, options
