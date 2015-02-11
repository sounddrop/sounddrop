
$(document).on("ready page:load", function(){

  var storyAtPlay; 
  var playPauseButton = $('.play-button');
  var state = {
      isPlaying: false,
      isBuffering : false
  };
  var options = {
    onfinish : function(){
      playPauseButton.html('<span class="glyphicon glyphicon-play-circle"></span>');
      //hideForwardAndBackwardButton();
    }
  }

  $(".button-like").submit(function(event) {
    event.preventDefault();
    $.ajax ({
      url: '/stories/'+ story.id +'/upvote',
      method: 'POST',
    }).success(function(result) {
      $("#votes").html(result.count_votes)
    });
  });

  function showForwardAndBackwardButton(){
    $(".forward").show();
    $(".backward").show();
  }
  function hideForwardAndBackwardButton(){
    $(".forward").hide();
    $(".backward").hide();
  }    

  function setupBufferingState(){
    if(state.isBuffering) {
      //hideForwardAndBackwardButton();
      playPauseButton.html('<span class="glyphicon glyphicon-play-circle"></span>');
      state.isBuffering = false;
    }else{
      playPauseButton.html('<span class="glyphicon glyphicon-refresh glyphicon-refresh-animate"></span>');
      //hideForwardAndBackwardButton();
      state.isBuffering = true;
    }
  }  

  function setupPlayOrPauseState(){
    if(state.isPlaying) {
      // hideForwardAndBackwardButton();
      storyAtPlay.pause();
      playPauseButton.html('<span class="glyphicon glyphicon-play-circle"></span>');
      state.isPlaying = false;
    }else {
      //showForwardAndBackwardButton();
      storyAtPlay.play();
      playPauseButton.html('<span class="glyphicon glyphicon-pause"></span>');
      state.isPlaying = true;
    }
  }

   SC.initialize({
     client_id: '69e93cf2209402f6f3137a6452cf498f'
   });
  //setup on click
  playPauseButton.on('click', function(event) {
    if (storyAtPlay) {
      setupPlayOrPauseState();
    }else{
      setupBufferingState();
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
        //hideForwardAndBackwardButton();
      }
    });
  }, 3000);


});
