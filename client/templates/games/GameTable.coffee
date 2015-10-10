Template.GameTable.helpers
  round: ->
    roundId = FlowRouter.getParam 'roundId'

    Rounds.findOne roundId

  players: ->
    roundId = FlowRouter.getParam 'roundId'

    Players.find roundId: roundId

  hasFinished: ->
    roundId = FlowRouter.getParam 'roundId'

    round = Rounds.findOne roundId

    round?.hasFinished()
