$(document).ready(function() {
  var form = $('form#new_drop');
  form.on('submit', function(e) {
    if($('input#sc_url').val() == '' && $('select#drop_sc_track').val() == '') {
      var message = $("<li>SoundCloud track and SoundCloud link can't both be blank</li>");
      var ul = $('<ul>').append(message);
      var div = $('<div>Sorry about that! There is an error</div>').append(ul);
      var alert = $('<div class="alert alert-danger">').append(div);
      var error_box = $('<div id="error_explanation">').append(alert);
      form.prepend(error_box);
      return false;
    }
  });
});
