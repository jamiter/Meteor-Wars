Template.RoundSettings.helpers
  round: ->
    roundId = FlowRouter.getParam 'roundId'

    Rounds.findOne _id: roundId

  hostName: ->
    Players.findOne(userId: @createdBy)?.name or 'the host'

  canJoin: ->
    @canJoin Meteor.userId()

  canStart: ->
    @canStart Meteor.userId()

Template.RoundSettings.events
  'click .join-game': (event) ->
    @addPlayer userId: Meteor.userId()

  'click .leave-game': (event) ->


  'click .start-game': (event) ->
    @start()

    FlowRouter.go "/games/#{@gameId}/rounds/#{@_id}/play"

  'click .go-to-game': (event) ->
    FlowRouter.go "/games/#{@gameId}/rounds/#{@_id}/play"
