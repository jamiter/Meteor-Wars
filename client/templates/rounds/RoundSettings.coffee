findRound = ->
  return unless roundId = FlowRouter.getParam 'roundId'

  Rounds.findOne _id: roundId

Template.RoundSettings.onCreated ->
  @autorun =>
    if (round = findRound()) and round.hasStarted()
      FlowRouter.go "/games/#{round.gameId}/rounds/#{round._id}/play"

Template.RoundSettings.onRendered ->
  selectInitialized = false

  @autorun =>
    if not selectInitialized and findRound()
      selectInitialized = true

      Meteor.setTimeout ->
        @$('select').material_select()
      , 100

Template.RoundSettings.helpers
  round: ->
    findRound()

  hostName: ->
    Players.findOne(userId: @createdBy)?.name or 'the host'

  canJoin: ->
    @canJoin Meteor.userId()

  canStart: ->
    @canStart Meteor.userId()

  imOwner: ->
    Meteor.userId() is @createdBy

  maps: ->
    GameMaps.find(gameId: @gameId)

Template.RoundSettings.events
  'click .join-game': (event) ->
    @addPlayer userId: Meteor.userId()

  'click .leave-game': (event) ->

  'click .start-game': (event) ->
    round = findRound()

    Meteor.call 'round/start', round._id, (err) ->
      if err
        alert err.message
      else
        FlowRouter.go "/games/#{round.gameId}/rounds/#{round._id}/play"

  'click .go-to-game': (event) ->
    FlowRouter.go "/games/#{@gameId}/rounds/#{@_id}/play"

  'click .add-ai': ->
    roundId = FlowRouter.getParam 'roundId'

    Meteor.call 'round/add-ai', roundId

  'change #map-select': (e) ->
    if gameMapId = $(e.currentTarget).val()
      @set gameMapId: gameMapId
