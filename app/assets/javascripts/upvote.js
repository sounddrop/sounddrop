$(document).ready(function(){

  $("#likebutton").on("ajax:success", function(e,result,status, xhr) {
    $("#votes").html(result.count_votes);
  });
 
});




