
$(document).on("ready page:load", function(){
  $(".button-like").submit(function(event) {
    event.preventDefault();
    $.ajax ({
      url: '/stories/'+ story.id +'/upvote',
      method: 'POST',
    }).success(function(result) {
      $("#votes").html(result.count_votes)
    });
  });


  var storyAtPlay; 
  var playPauseButton = $('.play-button');
  var state = {
      isPlaying: false,
      isBuffering : false
  };
  var options = {
    onfinish : function(){
      playPauseButton.html('<span class="glyphicon glyphicon-play-circle"></span>');
    }
  }

   SC.initialize({
     client_id: '69e93cf2209402f6f3137a6452cf498f'
   });
  //setup on click
  playPauseButton.on('click', function(event) {
    if (storyAtPlay) {
      if(state.isPlaying) {
        storyAtPlay.pause();
        playPauseButton.html('<span class="glyphicon glyphicon-play-circle"></span>');
        state.isPlaying = false;
      }else {
        storyAtPlay.play();
        playPauseButton.html('<span class="glyphicon glyphicon-pause"></span>');
        state.isPlaying = true;
      }
    }else{
      if(state.isBuffering) {
        playPauseButton.html('<span class="glyphicon glyphicon-play-circle"></span>');
        state.isBuffering = false;
      }else{
        playPauseButton.html('<span class="glyphicon glyphicon-refresh glyphicon-refresh-animate"></span>');
        state.isBuffering = true;
      }
    }
  });
  //Fetch stream 
  setTimeout( function (){
    SC.stream(storyAtSC.id, options ,function(sound){
      //if we comment this line we can test the else ( if story is not true)
      storyAtPlay = sound;
      console.log("story ready");
      if(state.isBuffering) {
        storyAtPlay.play();
        playPauseButton.html('<span class="glyphicon glyphicon-pause"></span>');
        state.isPlaying = true;
        state.isBuffering = false;
      }
    });
  }, 3000);


 });
