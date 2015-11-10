@UnitTypes = new Mongo.Collection 'unittypes',
  transform: (data) ->
    new UnitType data

class @UnitType extends Model

  @_collection: UnitTypes
