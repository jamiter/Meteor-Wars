@UnitTypes = new Mongo.Collection 'UnitTypes',
  transform: (data) ->
    new UnitType data

class UnitType extends Model

  @_collection: UnitTypes
