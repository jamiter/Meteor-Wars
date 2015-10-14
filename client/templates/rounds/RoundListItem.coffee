Template.RoundListItem.helpers
  date: ->
    moment(@createdAt).format('LLL')
  name: ->
    @findGame()?.name or @name or @_id
