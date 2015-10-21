Template.PlayerWinnerBar.helpers
  textColor: ->
    if tinycolor(@getTeamColor()).isDark()
      '#fff'
    else
      '#000'
  unitsLeft: ->
    Units.find
      playerId: @_id
      roundId: @roundId
    .count()
