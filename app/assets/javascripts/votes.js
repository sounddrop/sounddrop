$("#like_button").click(function(event) {
  event.preventDefault();
  $.ajax ({
    url: '/stories/<%=@story.id %>/upvote', method: 'POST'
  }).success(function(result) {
    $("#votes").html(result.count_votes);
  });
});