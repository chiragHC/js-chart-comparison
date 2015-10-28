@FusionChartsManager = class FusionChartsManager extends BaseChartsManager
  constructor: -> FusionCharts.ready super()

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

    generateScatterData = (size) =>
      for [0..size]
        x: @_getRandomInt(23, 95)
        y: @_getRandomInt(1000, 8000)

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
