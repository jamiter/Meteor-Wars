Template.GameMapEditorToolbar.onRendered ->
  @$('ul.tabs').tabs().tabs('select_tab', 'units-tab')

Template.GameMapEditorToolbar.events
  'click .plus-x': (e) ->
    @map.update $inc: 'dimensions.0': 1

  'click .minus-x': (e) ->
    @map.update $inc: 'dimensions.0': -1

  'click .plus-y': (e) ->
    @map.update $inc: 'dimensions.1': 1

  'click .minus-y': (e) ->
    @map.update $inc: 'dimensions.1': -1
