# Start AI when a turn is started
Turns.after.insert (userId, doc) ->
  player = Players.findOne doc.playerId

  if player?.isAi()
    player.runAi().catch (err) ->
      console.error err, err.stack
      player.findRound().nextTurn()
