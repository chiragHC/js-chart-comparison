@FusionChartsManager = class FusionChartsManager
  constructor: ->
    FusionCharts.ready @_setupGraphs()
    @_setupInputs()

  _setupGraphs: ->
    (new FusionCharts
      type: 'bar2d'
      renderAt: 'bar'
      dataSource: @_fusionChartDataSource()
    ).render()

    (new FusionCharts
      type: 'pie2d'
      renderAt: 'pie'
      dataSource: @_fusionChartDataSource()
    ).render()

    (new FusionCharts
      type: 'column2d'
      renderAt: 'column'
      dataSource: @_fusionChartDataSource()
    ).render()

    (new FusionCharts
      type: 'line'
      renderAt: 'line'
      dataSource: @_fusionChartDataSource()
    ).render()

    getRandomInt = (min, max) -> Math.floor(Math.random() * (max - min + 1)) + min
    generateScatterData = (size) =>
      data = []
      for [0..size] then data.push
        x: getRandomInt(23, 95)
        y: getRandomInt(1000, 8000)
      data

    (new FusionCharts
      type: 'scatter'
      renderAt: 'scatter'
      dataSource:
        chart: {
          caption: "Sales of Beer & Ice-cream vs Temperature"
          subCaption: "Los Angeles Topanga"
          xAxisName: "Average Day Temperature"
          yAxisName: "Sales (In USD)"
          xAxisMinValue: "23"
          xAxisMaxValue: "95"
          yNumberPrefix: "$"
          xNumberSuffix: "° F"
          showYAxisLine: "1"
          theme: "fint"
        }
        dataset: [
          {
            seriesname: "Ice Cream"
            showregressionline: "1"
            data: generateScatterData(20)
          },
          {
            seriesname: "Beer"
            showregressionline: "1"
            data: generateScatterData(20)
          }
        ]
    ).render()

  _fusionChartDataSource: ->
    chart:
      caption: "Monthly revenue for last year"
      subCaption: "Harry's SuperMart"
      xAxisName: "Month"
      yAxisName: "Revenues (In USD)"
      numberPrefix: "$"
      theme: "fint"
    data:
      [
        {
          label: "Jul"
          value: "150000"
          tooltext: "Occupancy: 67%{br}Revenue:$150k{br}3 conferences hosted!"
        }
        {
          label: "Aug"
          value: "130000"
          tooltext: "Occupancy: 64%{br}Revenue:$130k{br}Lean summer period!"
        }
        {
          label: "Sep"
          tooltext: "Occupancy: 44%{br}Revenue: $80k{br}Reason: Renovating the Lobby"
          value: "95000"
        }
        {
          label: "Oct"
          value: "170000"
          tooltext: "Occupancy: 73%{br}Revenue:$170k{br}Anniversary Discount: 25%"
        }
        {
          label: "Nov"
          value: "155000"
          tooltext: "Occupancy: 70%{br}Revenue:$155k{br}2 conferences cancelled!"
        }
        {
          label: "Dec"
          value: "230000"
          tooltext: "Occupancy: 95%{br}Revenue:$230k{br}Crossed last year record!"
        }
      ]

  _setupInputs: ->
    $('button').on('click', @_handleDownloadClick)
    $('.graph').each (index, value) ->
      id = $(value).attr('id')
      $('#download').append $("<option value='#{id}'>#{id}</option>")

  _handleDownloadClick: ->
    canvas = $('#' + $('#download').val())
    $.post Routes.upload_and_download_path(), image: canvas[0].toDataURL(), (result) ->
      $("#result").attr('src', result.url)
