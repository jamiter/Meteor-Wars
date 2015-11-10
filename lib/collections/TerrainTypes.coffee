@TerrainTypes = new Mongo.Collection 'terraintypes',
  transform: (data) ->
    new TerrainType data

class @TerrainType extends Model

  @_collection: TerrainTypes
