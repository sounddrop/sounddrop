
$(document).on("ready page:load", function(){
  $(".button-like").submit(function(event) {
    event.preventDefault();
    $.ajax ({
      url: '/drops/'+ drop.id +'/upvote',
      method: 'POST',
    }).success(function(result) {
      $("#votes").html(result.count_votes)
    });
  });

});
