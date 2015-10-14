Rounds.before.insert (userId, doc) ->
  doc.createdBy ?= userId
  doc.updatedBy ?= userId

  doc.createdAt ?= new Date
  doc.updatedAt ?= new Date

Rounds.before.update (userId, doc) ->
  doc.updatedBy = userId
  doc.updatedAt = new Date
