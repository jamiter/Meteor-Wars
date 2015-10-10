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
