$(document).on("ready page:load", function(){
  $("#hide_comments").hide();
  $("#commentForm").submit(function(event) {
    event.preventDefault();
    $.ajax({
      url: '/comments/',
      type: 'POST',
      data: $('#commentForm').serialize()
    }).done(function() {
      $.ajax('/comments/index').done(function(comments) {
        $("#hide_comments").html(comments).show();
        $('#new_comment').val('');
      });     
    });
  });
});
