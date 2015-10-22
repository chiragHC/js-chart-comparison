@RGraphManager = class RGraphManager
  constructor: ->
    @_setupGraphs()
    @_setupInputs()

  _setupGraphs: ->
    (new RGraph.Bar
      id: "bar"
      data: [[4,8,3],[5,2,1],[8,4,2],[3,6,1],[5,1,0],[2,5,1]]
      options:
        colors: ['Gradient(#fbb:red)', 'Gradient(#bfb:green)','Gradient(#bbf:blue)']
        labels: @_rgraphLabels()
    ).draw()

    (new RGraph.Pie
      id: "pie"
      data: [4,8,3,5,2,1]
      options:
        labels: @_rgraphLabels()
    ).draw()

    (new RGraph.HBar
      id: "column"
      data: [4,8,3,5,2,1]
      options:
        labels: @_rgraphLabels()
    ).draw()

    (new RGraph.Line
      id: "line"
      data: [4,8,3,5,2,1]
      options:
        labels: @_rgraphLabels()
    ).draw()

    (new RGraph.Scatter
      id: "scatter"
      data: [[4,8,'red'],[5,2,'red'], [8,4,'red'],[3,6,'red'],[5,1,'red'],[2,5,'red'],[1,2,'red']]
      options:
        xmax: 10
        ymax: 10
        xscale: true
    ).draw()

  _rgraphLabels: ->
    ['Henning','Louis','John','Pete','Lucy','Fred']

  _setupInputs: ->
    $('button').on('click', @_handleDownloadClick)
    $('canvas').each (index, value) ->
      id = $(value).attr('id')
      $('#download').append $("<option value='#{id}'>#{id}</option>")

  _handleDownloadClick: ->
    canvas = $('#' + $('#download').val())
    $.post Routes.upload_and_download_path(), image: canvas[0].toDataURL(), (result) ->
      $("#result").attr('src', result.url)
