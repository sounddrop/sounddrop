$(document).on("ready page:load", function() {
  var storyAtPlay;
  var playPauseButton = $('.play-button');
  var state = {
    isPlaying: false,
    isBuffering: false
  };
  var options = {
    onfinish: function() {
      playPauseButton.html('<span class="glyphicon glyphicon-play-circle"></span>');
      //hideForwardAndBackwardButton();
    },
    autoPlay: false

    // whileplaying : function() {
    //   console.log(this.position);
    //   self.updateScrubber(this.position / (this.duration / 100));
    //   self.$timeLeft.text(self.formatTime(this.position / 1000));
    //   console.log(totalPercent,'My position');
    // }
  }

  function showForwardAndBackwardButton() {
    $(".forward").show();
    $(".backward").show();
  }

  function hideForwardAndBackwardButton() {
    $(".forward").hide();
    $(".backward").hide();
  }

  function setupBufferingState() {
    if (state.isBuffering) {
      //hideForwardAndBackwardButton();
      playPauseButton.html('<span class="glyphicon glyphicon-play-circle"></span>');
      state.isBuffering = false;
    } else {
      playPauseButton.html('<span class="glyphicon glyphicon-refresh glyphicon-refresh-animate"></span>');
      //hideForwardAndBackwardButton();
      state.isBuffering = true;
    }
  }

  function setupPlayOrPauseState() {
    if (state.isPlaying) {
      // hideForwardAndBackwardButton();
      pause();
    } else {
      //showForwardAndBackwardButton();
      play();
    }
  }

  function pause() {
    // state.isPlaying = false;
    storyAtPlay.pause();
    playPauseButton.html('<span class="glyphicon glyphicon-play-circle"></span>');
  }

  function play() {
    // state.isPlaying = true;
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
    playOrPause();
    // if (storyAtPlay) {
    //   console.log((storyAtPlay.duration / 1000) / 60);
    //   setupPlayOrPauseState();
    // } else {
    //   setupBufferingState();
    // }
  });


  //Fetch stream 
  //setTimeout(function() {
    SC.stream(storyAtSC.id, options, function(sound) {
      console.log("Streaming");
      //if we comment this line we can test the else ( if story is not true)
      storyAtPlay = sound;
      console.log("story ready");
      if (state.isBuffering) {
        storyAtPlay.play();
        playPauseButton.html('<span class="glyphicon glyphicon-pause"></span>');
        state.isPlaying = true;
        state.isBuffering = false;
        //hideForwardAndBackwardButton();
      }
    });
  //}, 1000);
});