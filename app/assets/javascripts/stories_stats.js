
  var fromDate  = "2015-02-01";
  var toDate = "2015-02-05";
  var path = '/charts?start_date=' + fromDate + '&finish_date=' + toDate;
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


  function getJson() {
      $.getJSON(path, function(response) {          
        options.xAxis.categories = response.categories;
        options.series = response.stats.map(function(x) {
          return { "name": x.title, "data": x.votes }; 
        });
          var chart = new Highcharts.Chart(options);
      });
  }

  $(document).on("ready page:load", function(){

    getJson();
    
    $("#change_button").click(function(event) {   
      var fromDate  = $("#start_date").val();
      var toDate = $("#finish_date").val();
      var path; 
      getJson();
    });   
  });

