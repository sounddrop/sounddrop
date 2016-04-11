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

function initMap() {
  var map = new google.maps.Map(document.getElementById('map'), {
    zoom: 15,
    center: { lat: dropLat, lng: dropLong }
  });

  var icon = {
    url: image,
    scaledSize: new google.maps.Size(50, 50)
  }

  var marker = new google.maps.Marker({
    position: map.getCenter(),
    icon: icon,
    map: map
  });
}

