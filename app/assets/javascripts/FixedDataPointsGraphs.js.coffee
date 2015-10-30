#= require jquery.color

@FixedDataPointsGraphs = class FixedDataPointsGraphs extends BaseChartsManager
  FIRST_GRAPH_SERIES: ["7.3.1", "7.3.2", "7.3.3", "7.3.4", "7.3.5", "7.3.6", "7.3.7"
      "7.3.8", "7.3.9", "7.3.10", "7.3.11", "7.3.12", "7.3.13", "7.3.14"]
  THIRD_GRAPH_SERIES: ["7.5.1.2", "7.5.2.2", "7.5.3.2", "7.5.6.2.1"]
  GRAPHS_PERIOD: [2007, 2008, 2009, 2010, 2011, 2012, 2013, 2014, 2015]
  MAX_TRANSACTIONS: 400
  MAX_DEAL_AMOUNT: 8000000

  _setupGraphs: ->
    FusionCharts.ready @_setupFirstFusionChart()
    FusionCharts.ready @_setupThirdFusionChart()
    @_setupFirstAmChart()
    @_setupThirdAmChart()
    @_setupFirstHighChart()
    @_setupThirdHighChart()

  _setupFirstFusionChart: ->
    generateCategory = => for i in @GRAPHS_PERIOD then label: i
    generateData = => for i in @GRAPHS_PERIOD then value: @_getRandomInt(0, @MAX_TRANSACTIONS)

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
          yAxisMaxValue: @MAX_TRANSACTIONS
          theme: "fint"
          showYAxisValues: 1
          showValues: 0
        categories:
          category: generateCategory()
        dataset: @_generateDataset(@FIRST_GRAPH_SERIES, generateData)
    ).render()

  _setupFirstAmChart: ->
    genereateProvider = (series, period) =>
      for year in period
        obj = {year: year}
        for serie in series then obj[serie] = @_getRandomInt(0, @MAX_TRANSACTIONS)
        obj

    generateGraphs = (series) =>
      for serie, index in series
        balloonText: "Total transactions with #{serie} set to 'Yes' is [[value]]"
        bullet: "round"
        title: serie
        valueField: serie
        fillAlphas: 0
        lineColor: @_getColor(index)

    AmCharts.makeChart("amcharts-line"
      titles: [
        {
          text: "1. Use of Proceeds over Time (2.3)"
          size: 15
        }
        {
          text: "Aggregated amount (7.1) of each 7.3 subfield"
          size: 12
          bold: false
        }
      ]
      type: "serial"
      theme: "light"
      legend:
        useGraphSettings: true
      dataProvider: genereateProvider(@FIRST_GRAPH_SERIES, @GRAPHS_PERIOD)
      valueAxes: [
        maximum: @MAX_TRANSACTIONS
        dashLength: 5
        title: "Number of transactions"
      ]
      startEffect: "easeOutSine"
      startDuration: 0.1
      graphs: generateGraphs(@FIRST_GRAPH_SERIES)
      categoryField: "year"
      categoryAxis:
        gridPosition: "start"
        axisAlpha: 0
        fillAlpha: 0.05
        fillColor: "#000000"
        gridAlpha: 0
        title: "Years"
      export:
        enabled: true
        position: "bottom-right"
        libs:
          autoLoad: false
    )

  _setupFirstHighChart: ->
    genereateSeries = (series, period) =>
      for serie, index in series
        obj = {name: serie}
        obj.data = for year in period then @_getRandomInt(0, @MAX_TRANSACTIONS)
        obj.color = @_getColor(index)
        obj

    $('#highcharts-line').highcharts({
        title:
          text: '1. Use of Proceeds over Time (2.3)'
          x: -20 
        subtitle:
          text: 'Aggregated amount (7.1) of each 7.3 subfield'
          x: -20
        xAxis:
          categories: @GRAPHS_PERIOD
          title:
            text: 'Years'
        yAxis:
          title:
            text: 'Number of transactions'
          min: 0
          max: @MAX_TRANSACTIONS
        legend: 
          layout: 'vertical'
          align: 'right'
          verticalAlign: 'middle'
          borderWidth: 0
        series: genereateSeries(@FIRST_GRAPH_SERIES, @GRAPHS_PERIOD)
    });


  _setupThirdFusionChart: ->
    generateCategory = ->
      getDate = (monthsBack) ->
        monthNamesShort = ['Jan', 'Feb', 'Mar', 'Apr', 'May', 'Jun'
          'Jul', 'Aug', 'Sep', 'Oct', 'Nov', 'Dec']
        date = new Date()
        date.setMonth(date.getMonth() - monthsBack);
        monthNamesShort[date.getMonth()] + '<br>' + date.getFullYear()
      for i in [0..19]
        label: getDate(i)
        x: i

    generateData = =>
      for i in [0..100]
        x: i % 20 #20 months
        y: @_getRandomInt(1, @MAX_DEAL_AMOUNT)

    (new FusionCharts
      type: 'scatter'
      renderAt: 'fusionchart-scatter'
      width: 800
      height: 500
      dataSource:
        chart:
          caption: "3. Anticipated Term Expiries"
          xAxisName: "Time"
          yAxisName: "Deal value"
          yNumberPrefix: "$"
          theme: "fint"
        categories:
          category: generateCategory()
        dataset: @_generateDataset(@THIRD_GRAPH_SERIES, generateData)
    ).render()

  _setupThirdAmChart: ->
    genereateProvider = (series) =>
      for [0..100]
        obj = date: new Date(@_getRandomInt(2007, 2015),
          @_getRandomInt(0, 11), @_getRandomInt(0, 30))
        for serie in series
          obj["#{serie}y"] = @_getRandomInt(0, @MAX_DEAL_AMOUNT)
        obj

    generateGraphs = (series) =>
      for serie, index in series
        bullet: "diamond"
        title: serie
        xField: "date"
        yField: "#{serie}y"
        lineAlpha: 0
        lineColor: @_getColor(index)

    AmCharts.makeChart("amcharts-scatter"
      titles: [
        text: "3. Anticipated Term Expiries"
        size: 15
      ]
      type: "xy"
      theme: "light"
      legend:
        useGraphSettings: true
      dataProvider: genereateProvider(@THIRD_GRAPH_SERIES)
      valueAxes: [{
        title: "Deal value"
        maximum: @MAX_DEAL_AMOUNT
        unit: "$"
        unitPosition: "left"
      }
      {
        "position": "bottom"
        "type": "date"
        "minimumDate": new Date(2007, 0, 0)
        "maximumDate": new Date()
        "title": "Time"
      }]
      graphs: generateGraphs(@THIRD_GRAPH_SERIES)
      pathToImages: 'amcharts/'
      chartScrollbar: {}
      chartCursor: {}
      export:
        enabled: true
        position: "bottom-right"
        libs:
          autoLoad: false
    )

  _setupThirdHighChart: ->
    genereateSeries = (series) =>
      for serie, index in series
        name: serie
        color: @_getColor(index)
        data: for [0..100]
          [new Date(@_getRandomInt(2007, 2015), @_getRandomInt(0, 11),
           @_getRandomInt(0, 30)).getTime(), @_getRandomInt(0, @MAX_DEAL_AMOUNT)]

    yAxisFormatter = -> '$ ' + Highcharts.numberFormat(@.value, 0)

    $('#highcharts-scatter').highcharts(
      chart:
        type: 'scatter'
        zoomType: 'xy'
      title:
        text: '3. Anticipated Term Expiries'
      xAxis:
        title:
          text: 'Time'
        type: 'datetime'
        min: new Date(2007, 0, 0).getTime()
        max: new Date().getTime()
      yAxis:
        title:
          text: 'Deal value'
        labels:
          formatter: yAxisFormatter
        min: 0
        max: @MAX_DEAL_AMOUNT
      plotOptions:
        scatter:
          tooltip:
            headerFormat: '<b>{series.name}</b><br>'
            pointFormat: '{point.x:%Y/%m/%d} - $ {point.y}'
      series: genereateSeries(@THIRD_GRAPH_SERIES)
    )

  _getColor: (index) ->
    index = Object.keys(jQuery.Color.names)[index]
    jQuery.Color.names[index]

  _generateDataset: (series, dataGenerator) =>
    for serie, index in series
      seriesname: serie
      data: dataGenerator()
      color: @_getColor(index)
