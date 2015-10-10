Template.GameOverview.helpers
  activeRounds: ->
    options =
      sort:
        finishedAt: 1
        startedAt: 1

    Rounds.find
      finishedAt: null
    ,
      options
