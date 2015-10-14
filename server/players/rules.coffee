Players.allow
  insert: -> true
  update: -> true

Players.deny
  update: (userId, doc) ->
    doc.userId isnt userId
