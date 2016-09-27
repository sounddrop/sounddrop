$(function() {
  $("#request").keyup(function(e) {
    var path = e.target.value;
    console.log(path);
    $.getJSON(path, function(response) {
      var responseContainer = $("#explorer-response");
      var prettyResponse = JSON.stringify(response, null, "    ");
      responseContainer.html(prettyResponse);
    });
  });
});