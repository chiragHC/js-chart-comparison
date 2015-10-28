#= require jquery.color

@FixedDataPointsGraphs = class FixedDataPointsGraphs extends FusionChartsManager
  _setupGraphs: ->
    getRandomInt = (min, max) -> Math.floor(Math.random() * (max - min + 1)) + min

    generateLineData = (size) ->
      data = []
      for [2007..2015] then data.push value: getRandomInt(0, 400)
      data

    getRandomColor = ->
      letters = '0123456789ABCDEF'.split('')
      color = '#'
      for i in [0..6] then color += letters[Math.floor(Math.random() * 16)]
      color

    generateLineCategory = ->
      data = []
      for i in [2007..2015] then data.push
        label: i
      data

    getColor = (index) ->
      index = Object.keys(jQuery.Color.names)[index]
      jQuery.Color.names[index]

    generateLineDataset = (series) ->
      data = []
      for serie, index in series then data.push
        seriesname: serie
        data: generateLineData()
        color: getColor(index)
      data

    (new FusionCharts
      type: 'msline'
      renderAt: 'line1'
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
          category: generateLineCategory()
        dataset: generateLineDataset([
          "7.3.1", "7.3.2", "7.3.3", "7.3.4", "7.3.5", "7.3.6", "7.3.7",
          "7.3.8", "7.3.9", "7.3.10", "7.3.11", "7.3.12", "7.3.13", "7.3.14"])
    ).render()
