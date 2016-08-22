var Map = {
  map: null,
  setMarker: function() {},
  init: function() {
    Map.map = new google.maps.Map(document.querySelector('[data-map]'), {
      zoom: 15,
      center: { lat: 10, lng: 12 }
    });
  }
  changeMap: function() {},
  createMarker: function(){
    var icon = {
      url: image,
      scaledSize: new google.maps.Size(50, 50)
    };



  }
};

Map.setMarker();
Map.init();
Map.changeMap();
Map.createMarker();
var markers = [ ];
var icon;
var image;
