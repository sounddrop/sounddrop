$(document).on("ready page:load", function() {
  var storyAtPlay;
  var playPauseButton = $('.play-button');
  var state = {
    isPlaying: false,
    isBuffering: false
  };
  hideForwardAndRewindButton();
  var options = {
    onfinish: function() {
      playPauseButton.html('<span class="glyphicon glyphicon-play-circle"></span>');
      hideForwardAndRewindButton();
    }
  }

  function showForwardAndRewindButton() {
    $(".forward").show();
    $(".rewind").show();
  }

  function hideForwardAndRewindButton() {
    $(".forward").hide();
    $(".rewind").hide();
  }

  function setupBufferingState() {
    if (state.isBuffering) {
      hideForwardAndRewindButton();
      playPauseButton.html('<span class="glyphicon glyphicon-play-circle"></span>');
      state.isBuffering = false;
    } else {
      hideForwardAndRewindButton();
      playPauseButton.html('<span class="glyphicon glyphicon-refresh glyphicon-refresh-animate"></span>');
      state.isBuffering = true;
    }
  }

  function setupPlayOrPauseState() {
    if (state.isPlaying) {
      pause();
    } else {
      play();
    }
  }

  function pause() {
    hideForwardAndRewindButton();
    storyAtPlay.pause();
    playPauseButton.html('<span class="glyphicon glyphicon-play-circle"></span>');
  }

  function play() {
    showForwardAndRewindButton();
    storyAtPlay.play();
    playPauseButton.html('<span class="glyphicon glyphicon-pause"></span>');
  }

  function playOrPause() {
    if (storyAtPlay.paused || storyAtPlay.playState == 0) {
      play();
    } else {
      pause();
    }
  }

  SC.initialize({
    client_id: '69e93cf2209402f6f3137a6452cf498f'
  });

  $('.rewind').on('click', function(event) {
    //pause();
    var rewind = storyAtPlay.position - 5000;
    if (rewind > 0 && rewind < storyAtPlay.duration) {
      storyAtPlay.setPosition(rewind);
    } else {
      storyAtPlay.setPosition(0);
    }
  });

  $('.forward').on('click', function(event) {
    //pause();
    var forward = storyAtPlay.position + 5000;
    if (forward < storyAtPlay.duration) {
      storyAtPlay.setPosition(forward);
    } else {
      storyAtPlay.setPosition(storyAtPlay.duration);
    }
  });

  //setup on click
  playPauseButton.on('click', function(event) {
    showForwardAndRewindButton();
    playOrPause();
  });


  //Fetch stream 
  setTimeout(function() {
    SC.stream(storyAtSC.id, options, function(sound) {
      console.log("Streaming");
      //if we comment this line we can test the else ( if story is not true)
      storyAtPlay = sound;
      console.log("story ready");
      if (state.isBuffering) {
        hideForwardAndRewindButton();
        storyAtPlay.play();
        playPauseButton.html('<span class="glyphicon glyphicon-pause"></span>');
        state.isPlaying = true;
        state.isBuffering = false;
     
      }
    });
  }, 1000);
});