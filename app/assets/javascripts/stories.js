$("#like_button").click(function(event) {
  event.preventDefault();
  $.ajax ({
    url: '/stories/178594490/upvote', method: 'POST'
  }).success(function(result) {
    $("#votes").html(result.count_votes);
  });
});

// $(function() {
//     $('#like_button').click(function(event){
//       event.preventDefault();
//     $.ajax ({
//     url: '/stories/178594490/upvote', method: 'POST'
//         var obj = $(this);
//         if( obj.data('liked') ){
//             obj.data('liked', false);
//             obj.html('Like');
//         }
//         else{
//             obj.data('liked', true);
//             obj.html('Unlike');
//         }
//     });
// });

//     disable css class - not allow to click // unbind the click