$("#like_button").click(function(event) {
  event.preventDefault();
  $.ajax ({
    url: '/stories/178594490/upvote', method: 'POST'
  }).success(function(result) {
    $("#votes").html(result.count_votes);
  });
});