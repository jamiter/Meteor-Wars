GameMaps.allow
  insert: -> true
  update: -> true

GameMaps.deny
  update: (userId, doc) ->
    doc.createdBy isnt userId

