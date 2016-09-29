$(function() {

  var makeRequest = function(e) {
    var path = $("#request").val();
    console.log(path)
    $.getJSON(path, function(response) {
      var responseContainer = $("#explorer-response");
      var prettyResponse = JSON.stringify(response, null, "    ");
      responseContainer.html(prettyResponse);
    });
  };

  $("#request").keyup(makeRequest);

  $('.endpoints a').click(function(e) {
    e.preventDefault();
    $("#request").val($(this).attr("href"));
    makeRequest();
  });



});

