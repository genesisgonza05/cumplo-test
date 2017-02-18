class Reports
  constructor: ->
    @datepickers()
    @click_get_data()
    @charts() if $('canvas').length

  datepickers: ->
    $('#datepicker-start-date').datetimepicker format: 'MM/DD/YYYY'
    $('#datepicker-end-date').datetimepicker({
      format: 'MM/DD/YYYY',
      useCurrent: false })

    $('#datepicker-start-date').on 'dp.change', (e) ->
      $('#datepicker-end-date').data('DateTimePicker').minDate e.date

    $('#datepicker-end-date').on 'dp.change', (e) ->
      $('#datepicker-start-date').data('DateTimePicker').maxDate e.date

  click_get_data: ->
    $("#get-data").click ->
      $(".box-loading").removeClass("hidden")

  charts: ->
    ctx_dollar = $('#myChartDollar')
    ctx_uf = $('#myChartUF')

    @chart_dollar(ctx_dollar) if ctx_dollar.length && $("#resport_values_dollar").val().length
    @chart_uf(ctx_uf) if ctx_uf.length && $("#resport_values_uf").val().length

  chart_dollar: (ctx_dollar) ->
    dollars = $("#resport_values_dollar").val()
    @chart_report(ctx_dollar, dollars, "Chart Dollar value in CLP (value / date)")

  chart_uf: (ctx_uf) ->
    uf = $("#resport_values_uf").val()
    @chart_report(ctx_uf, uf, "Chart UF value in CLP (value / date)")


  chart_report: (ctx, reports, label) ->
    reports = JSON.parse(reports)
    dates = []
    values = []
    $.each reports, (i, report) ->
      dates.push(report.table.date)
      values.push(report.table.value)

    data = 
      labels: dates
      datasets: [ {
        label: label
        fill: false
        lineTension: 0.1
        backgroundColor: 'rgba(75,192,192,0.4)'
        borderColor: 'rgba(75,192,192,1)'
        borderCapStyle: 'butt'
        borderDash: []
        borderDashOffset: 0.0
        borderJoinStyle: 'miter'
        pointBorderColor: 'rgba(75,192,192,1)'
        pointBackgroundColor: '#fff'
        pointBorderWidth: 1
        pointHoverRadius: 5
        pointHoverBackgroundColor: 'rgba(75,192,192,1)'
        pointHoverBorderColor: 'rgba(220,220,220,1)'
        pointHoverBorderWidth: 2
        pointRadius: 1
        pointHitRadius: 10
        data: values
        spanGaps: false
      } ]

    myLineChart = new Chart(ctx,
      type: 'line'
      data: data
      responsive: false)



@Reports = Reports

ready = ->
  new Reports()

@Reports = Reports

$(document).on('ready',ready)
$(document).on('page:load',ready)