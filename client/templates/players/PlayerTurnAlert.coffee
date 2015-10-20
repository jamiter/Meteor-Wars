Template.PlayerTurnAlert.onRendered ->

  @$('.modal').openModal
    opacity: 0.1
    complete: =>
      $(@firstNode).remove()

  Meteor.setTimeout =>
    @$('.modal').closeModal()
  , 2000

Template.PlayerTurnAlert.helpers
  unitData: ->
    teamColor: @getTeamColor()
    strokeTeamColor: tinycolor(@getTeamColor()).darken(30).toString()
