Template.RoundCreateForm.events
  'click .create-game': (event) ->
    event.preventDefault()

    gameId = FlowRouter.getParam 'gameId'

    round = Games.findOne(gameId)?.newRound()

    round.addPlayer userId: Meteor.userId()

    FlowRouter.go "/games/#{gameId}/rounds/#{round._id}"
