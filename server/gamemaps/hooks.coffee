# Start AI when a turn is started
GameMaps.before.insert (userId, doc) ->
  doc.createdBy = userId
