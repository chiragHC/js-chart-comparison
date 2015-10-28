@BaseChartsManager = class BaseChartsManager
  constructor: ->
    @_setupGraphs()
    @_setupInputs()

  _getRandomInt: (min, max) -> Math.floor(Math.random() * (max - min + 1)) + min

  _setupInputs: ->
    $('button').on('click', @_handleDownloadClick)
    $('.graph').each (index, value) ->
      id = $(value).attr('id')
      $('#download').append $("<option value='#{id}'>#{id}</option>")

  _handleDownloadClick: ->
    svg = $('svg', '#' + $('#download').val())
    canvas = $('canvas')
    canvas.attr('height', svg.attr('height'))
    canvas.attr('width', svg.attr('width'))

    #svg[0].outherHTML doesn't work for SVN objects on IE
    canvg(canvas[0], $('<div>').append($(svg).clone()).html(),
      ignoreMouse: true
      ignoreAnimation: true)

    $.post Routes.upload_and_download_path(), image: canvas[0].toDataURL(), (result) ->
      $("#result").attr('src', result.url)
