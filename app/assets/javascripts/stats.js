
var options = {
    chart: {
      renderTo: "stories_chart",
      type: 'column',
      spacingBottom: 35,
      spacingTop: 30,
      spacingLeft: 10,
      spacingRight: 15,
    },

    title: {
      text: "Stats"
    },

    subtitle: {
      text: "Check how popular your story is on SoundDrop"
    },

    xAxis: {
    },

    yAxis: {
      title: {text: "Likes"},
    },

    legend: {
      layout: 'vertical',
      align: 'right',
      verticalAlign: 'middle',
      borderWidth: 0,
    },

    tooltip: {
      valueSuffix: ' likes'
    },

    series: []
  };

  function loadStats() {
    var fromDate  = $("#start_date").val();
    var toDate = $("#finish_date").val();
    var path = '/charts?start_date=' + fromDate + '&finish_date=' + toDate;
      $.getJSON(path, function(response) {
        options.xAxis.categories = response.categories;
        options.series = response.stats.map(function(x) {
          return { "name": x.title, "data": x.votes };
        });
          var chart = new Highcharts.Chart(options);
      });
  }

  $(document).on("ready page:load", function(){
    loadStats();

    $("#change_button").click(function(event) {
      loadStats();
    });

  });
