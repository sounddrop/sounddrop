$(function() {

  var makeRequest = function(e) {
    var path = $("#request").val();
    console.log(path)
    $.getJSON(path, function(response) {
      var responseContainer = $("#explorer-response");
      var prettyResponse = JSON.stringify(response, null, "    ");
      responseContainer.html(prettyResponse);
    });
  }

  $("#request").keyup(makeRequest);

  $('.endpoints').click(function(e) {
    e.preventDefault();
    makeRequest($(this)attr("href"))
  })



});




// $(function() {
//   $("#request").keyup(function(e) {
//     var path = e.target.value;
//     console.log(path);
//   });
// });
//
// $('.endpoints').click(
//   function(e){
//     e.preventDefault();
//     var path = $(this).attr("href");
//     $.getJSON(path, function(response) {
//       var responseContainer = $("#explorer-response");
//       var prettyResponse = JSON.stringify(response, null, "    ");
//       responseContainer.html(prettyResponse);
//       });
//   }
//
//   function makeRequest(path) {
//     $.getJSON(path, function(response) {
//       var responseContainer = $("#explorer-response");
//       var prettyResponse = JSON.stringify(response, null, "    ");
//       responseContainer.html(prettyResponse);
//     });
//   }
