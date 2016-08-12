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
    var rewind = dropAtPlay.currentTime() - 5000;
    if (rewind > 0 && rewind < dropAtPlay.streamInfo.duration) {
      dropAtPlay.seek(rewind);
    } else {
      dropAtPlay.seek(0);
    }
  });

  $('.forward').on('click', function(event) {
    //pause();
    var forward = dropAtPlay.currentTime() + 5000;
    if (forward < dropAtPlay.streamInfo.duration) {
      dropAtPlay.seek(forward);
    } else {
      dropAtPlay.seek(dropAtPlay.streamInfo.duration);
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
    if (typeof(dropAtSC) !== "undefined") {
      SC.stream('/tracks/' + dropAtSC.id).then(function(sound) {
        console.log("Streaming");
        if (sound.options.protocols[0] === 'rtmp') {
            sound.options.protocols.splice(0, 1);
        }
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
