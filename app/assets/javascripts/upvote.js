$(document).ready(function(){
 

 
  $("#like_button").click(function(event) {
      event.preventDefault();
        $.ajax ({
        url: '/stories/<%=@story.id %>/upvote',
        method: 'POST'
          }).success(function(result) {
          $("#votes").html(result.count_votes);
        });
  });

  $("#like_button_with_link_to").on("ajax:success", function(e,result,status, xhr) {
    $("#votes").html(result.count_votes);
  });
 
 });




