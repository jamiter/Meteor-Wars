# Start AI when a turn is started
Turns.after.update (userId, doc, fieldNames) ->
  if doc.startedAt and 'startedAt' in fieldNames

    player = Players.findOne doc.playerId

    if player?.isAi()
      player.runAi().catch (err) ->
        console.error err, err.stack
        player.findRound().nextTurn()
