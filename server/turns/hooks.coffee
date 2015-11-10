# Start AI when a turn is started
Turns.after.insert (userId, doc) ->
  player = Players.findOne doc.playerId

  if player?.isAi()
    Meteor.setTimeout ->
      player.runAi().catch (err) ->
        console.error err, err.stack
        player.findRound().nextTurn()
    , 1800

# Auto finish turns that take to long
timeoutTime = 2 * 60 * 1000 # 2 minutes

Turns.after.insert (userId, doc) ->
  # TODO: work out turn auto finish
  return

  Meteor.setTimeout ->
    if turn = Turns.findOne(doc._id)
      if not turn.hasFinished()
        turn.findRound().nextTurn()
  , timeoutTime
