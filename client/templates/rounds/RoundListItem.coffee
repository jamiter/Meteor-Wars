Template.RoundListItem.helpers
  date: ->
    moment(@createdAt).format('LLL')
