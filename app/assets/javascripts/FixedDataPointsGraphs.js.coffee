#= require jquery.color

@FixedDataPointsGraphs = class FixedDataPointsGraphs extends BaseChartsManager
  _setupGraphs: ->
    FusionCharts.ready @_setupFirstGraph()
    #second graph have open questions yet
    FusionCharts.ready @_setupThirdGraph()

  _setupFirstGraph: ->
    generateCategory = -> for i in [2007..2015] then label: i
    generateData = => for [2007..2015] then value: @_getRandomInt(0, 400)

    (new FusionCharts
      type: 'msline'
      renderAt: 'fusionchart-line'
      width: 800
      height: 500
      dataSource:
        chart:
          caption: "1. Use of Proceeds over Time (2.3)"
          subCaption: "Aggregated amount (7.1) of each 7.3 subfield"
          xAxisName: "Years"
          yAxisName: "Number of transactions"
          theme: "fint"
          showYAxisValues: 1
          showValues: 0
        categories:
          category: generateCategory()
        dataset: @_generateDataset([
          "7.3.1", "7.3.2", "7.3.3", "7.3.4", "7.3.5", "7.3.6", "7.3.7",
          "7.3.8", "7.3.9", "7.3.10", "7.3.11", "7.3.12", "7.3.13", "7.3.14"],
          generateData)
    ).render()

  _setupThirdGraph: ->
    generateCategory = ->
      getDate = (monthsBack) ->
        monthNamesShort = ['Jan', 'Feb', 'Mar', 'Apr', 'May', 'Jun',
          'Jul', 'Aug', 'Sep', 'Oct', 'Nov', 'Dec']
        date = new Date()
        date.setMonth(date.getMonth() - monthsBack);
        monthNamesShort[date.getMonth()] + '<br>' + date.getFullYear()
      for i in [17..0]
        label: getDate(i)
        x: i

    generateData = =>
      for [0..17]
        x: @_getRandomInt(0, 17)
        y: @_getRandomInt(1, 8000000)

    (new FusionCharts
      type: 'scatter'
      renderAt: 'fusionchart-scatter'
      width: 800
      height: 500
      dataSource:
        chart: {
          caption: "3. Anticipated Term Expiries"
          xAxisName: "Time"
          yAxisName: "Deal value"
          yNumberPrefix: "$"
          theme: "fint"
        }
        categories:
          category: generateCategory()
        dataset: @_generateDataset(["7.5.1.2", "7.5.2.2", "7.5.3.2", "7.5.6.2.1"],
          generateData)
    ).render()

  _getColor: (index) ->
    index = Object.keys(jQuery.Color.names)[index]
    jQuery.Color.names[index]

  _generateDataset: (series, dataGenerator) ->
    data = []
    for serie, index in series then data.push
      seriesname: serie
      data: dataGenerator()
      color: @_getColor(index)
    data
