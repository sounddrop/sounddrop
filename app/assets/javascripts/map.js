var Map = {
  map: null,
  setMarker: function() {},
  init: function() {
    Map.map = new google.maps.Map(document.getElementById('map'), {
      var dropContainerNode = document.querySelector("[data-drop-track]");
      if (dropContainerNode !== null) {
        zoom: 15,
        center: { lat: dropContainerNode.dataset.dropLat, lng: dropContainerNode.dataset.dropLong }
      }
    };
  }
  changeMap: function() {},
  createMarker: function(){
    var icon = {
      url: soundDropMarker,
      scaledSize: new google.maps.Size(50, 50)
    };



  }
};

var markers = [ ];


setMarkers: function() {}
createMarkers: function() {}
