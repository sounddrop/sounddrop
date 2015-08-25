$(document).on("ready page:load", function() {
  var dropAtPlay;
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

  function setupPlayOrPauseState(){
    if(state.isPlaying) {
      hideForwardAndRewindButton();
      dropAtPlay.pause();
      playPauseButton.html('<span class="glyphicon glyphicon-play-circle"></span>');
      state.isPlaying = false;
    }else {
      showForwardAndRewindButton();
      dropAtPlay.play();
      playPauseButton.html('<span class="glyphicon glyphicon-pause"></span>');
      state.isPlaying = true;
    }
  }

  SC.initialize({
    client_id: '69e93cf2209402f6f3137a6452cf498f'
  });

  $('.rewind').on('click', function(event) {
    //pause();
    var rewind = dropAtPlay.position - 5000;
    if (rewind > 0 && rewind < dropAtPlay.duration) {
      dropAtPlay.setPosition(rewind);
    } else {
      dropAtPlay.setPosition(0);
    }
  });

  $('.forward').on('click', function(event) {
    //pause();
    var forward = dropAtPlay.position + 5000;
    if (forward < dropAtPlay.duration) {
      dropAtPlay.setPosition(forward);
    } else {
      dropAtPlay.setPosition(dropAtPlay.duration);
    }
  });

  //setup on click
  playPauseButton.on('click', function(event) {
    if (dropAtPlay) {
      showForwardAndRewindButton();
      setupPlayOrPauseState();
    }else{
      hideForwardAndRewindButton();
      setupBufferingState();
    }
  });


  //Fetch stream
  setTimeout(function() {
    if (typeof(dropAtSC) != "undefined") {
      SC.stream(dropAtSC.id, options, function(sound) {
        console.log("Streaming");
        //if we comment this line we can test the else ( if drop is not true)
        dropAtPlay = sound;
        console.log("drop ready");
        if (state.isBuffering) {
          showForwardAndRewindButton();
          dropAtPlay.play();
          playPauseButton.html('<span class="glyphicon glyphicon-pause"></span>');
          state.isPlaying = true;
          state.isBuffering = false;

        }
      });
    }
  }, 3000);
});
