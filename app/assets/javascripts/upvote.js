
$(document).on("ready page:load", function(){
  $(".button-like").submit(function(event) {
    event.preventDefault();
    $.ajax ({
      url: '/stories/'+ story.id +'/upvote',
      method: 'POST',
    }).success(function(result) {
      $("#votes").html(result.count_votes);
      $("#session").html('List: ' + result.user_session)
    });
  });
 });
