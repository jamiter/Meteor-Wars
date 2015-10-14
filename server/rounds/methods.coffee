Meteor.methods
  'round/nextTurn': (roundId) ->
    check roundId, String

    return if Meteor.isClient
    return unless roundId
    return unless @userId

    return unless round = Rounds.findOne roundId
    return unless player = Players.findOne userId: @userId, roundId: roundId
    # return if player._id isnt round.getCurrentPlayer()._id

    round.nextTurn()

  'round/surrender': (roundId) ->
    check roundId, String

    player = Players.findOne
      roundId: roundId
      userId: @userId

    if player
      Units.remove playerId: player._id

  'round/add-ai': (roundId) ->
    check roundId, String

    round = Rounds.findOne
      _id: roundId
      createdBy: @userId

    unless round
      throw new Meteor.Error "NOT_ROUND_OWNER"

    aiPlayersCount = Players.find(
      roundId: roundId
      userId: null
    ).count()

    round.addPlayer
      name: "Computer #{aiPlayersCount + 1}"
