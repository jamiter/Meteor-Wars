class @Model
  constructor: (data = {}) ->
    _.extend this, data

  update: (options) ->
    @constructor._collection?.update _id: @_id, options

  set: (data) ->
    # Hard override this object so it is imediantly up to date
    for key, value of data
      @[key] = value

    @update $set: data

  remove: (options) ->
    @constructor._collection?.remove _id: @_id, options
