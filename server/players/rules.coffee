Players.allow
  insert: -> true
  update: -> true
  remove: -> true

Players.deny
  update: (userId, doc) ->
    doc.userId isnt userId
