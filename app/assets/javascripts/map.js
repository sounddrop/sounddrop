var Map = {
  map: null,
  setMarker: function() {},
  init: function() {
    var dropLat, dropLong;
    var dropContainerNode = document.querySelector("[data-drop-track]");
    if (dropContainerNode !== null) {
      dropLat = parseFloat(dropContainerNode.dataset.dropLat);
      dropLong = parseFloat(dropContainerNode.dataset.dropLong);
    } else {
       dropLat = 52.536;
       dropLong = 13.392;
    }
    Map.map = new google.maps.Map(document.getElementById('map'), {
      zoom: 15,
      center: { lat: dropLat, lng: dropLong }
    });
  },

  createMarker: function(){
    var icon = {
      url: soundDropMarker,
      scaledSize: new google.maps.Size(50, 50)
    };

  }

};



//var markers = [ ];
// setMarkers: function() {}
// createMarkers: function() {}

 // var marker = new google.maps.Marker({
  //   // maps API position, what is map.getCenter return
  //   position: map.getCenter(),
  //   icon: icon,
  //   map: map
  // });