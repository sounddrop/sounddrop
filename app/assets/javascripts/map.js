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

    var icon = {
      url: soundDropMarker,
      scaledSize: new google.maps.Size(50, 50)
    };

    Map.map = new google.maps.Map(document.getElementById('map'), {
      zoom: 15,
      center: { lat: dropLat, lng: dropLong }
    });

    var coordinateList = map.dataset.drops ? JSON.parse(map.dataset.drops) : [];

    for (var i = 0; i < coordinateList.length; i++ ){
      var marker = new google.maps.Marker({
        position: {'lat': coordinateList[i]['lat'], 'lng': coordinateList[i]['lng']},
        icon: icon,
        map: Map.map,
        dropUrl: location.protocol + '//' + location.host + '/drops/' + coordinateList[i]['id']
      });

      google.maps.event.addListener(marker, 'click', function() {
        window.location.href = this.dropUrl;
      });
    }
  }
};
