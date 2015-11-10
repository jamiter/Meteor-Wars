Template.GameMapUnitTypeBar.onCreated ->

Template.GameMapUnitTypeBar.onRendered ->
  @$('.unit-type').draggable
    helper: 'clone'

Template.GameMapUnitTypeBar.helpers
  types: ->
    UnitTypes.find()

  typeData: ->
    color = switch FlowRouter.getQueryParam 'playerIndex'
      when '0'
        "#48C8F8"
      when '1'
        "#F00008"
      when '2'
        "#FF0"
      else
        "#999"

    teamColor: color
    strokeTeamColor: tinycolor(color).darken(30).toString()
