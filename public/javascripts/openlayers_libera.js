var map;
var markers;
function openlayers_map() {
    //Creamos el mapa con la capa de OSM
    map = new OpenLayers.Map('map');
    layer = new OpenLayers.Layer.OSM( "Simple OSM Map");
    map.addLayer(layer);
    
    // Centramos el mapa en Vitoria
    find_address('Vitoria', center_map, 'none', 'none');
    
    // Añadimos una capa de Markers
    markers = new OpenLayers.Layer.Markers( "Markers" );
    map.addLayer(markers);
    
    // Cargamos cada uno de los puntitos para las bicicletas
    // Esta función es generada en tiempo real dentro del HTML
    // Un ejemplo de la sintaxis:
    //   find_address('Barakaldo', add_marker, '/users/1');
    cargar_markers_bicicletas();

}


function find_address(address, callback, marker_color, url) {
  OpenLayers.Request.GET({
    url: "http://nominatim.openstreetmap.org/search?q="+address+"&format=json&limit=1",
    scope: this,
    failure: this.requestFailure,
    success: function(response) {
       callback(response, marker_color, url);
    },
    headers: {"Content-Type": "application/x-www-form-urlencoded"}
  });
}


function requestFailure(response) {
  alert("Ha ocurrido un error al comunicar con el servicio de mapas. Por favor inténtelo de nuevo.");
}


function center_map(response, marker_color, url) {
  result = JSON.parse(response.responseText)
  var foundPosition = new OpenLayers.LonLat(result[0].lon, result[0].lat).transform(
          new OpenLayers.Projection("EPSG:4326"),
          map.getProjectionObject()
          );
  map.setCenter(foundPosition, 7);
}


function add_marker(response, marker_color, url) {
  // Procesamos la respuesta
  result = JSON.parse(response.responseText)
  var foundPosition = new OpenLayers.LonLat(result[0].lon, result[0].lat).transform(
    new OpenLayers.Projection("EPSG:4326"),
    map.getProjectionObject()
  );

  // Creamos el icono
  var size = new OpenLayers.Size(21,25);
  var offset = new OpenLayers.Pixel(-(size.w/2), -size.h);
  var icon = new OpenLayers.Icon('/javascripts/img/marker-'+ marker_color +'.png', size, offset);
  marker = new OpenLayers.Marker(foundPosition,icon);
  
  // Al hacer clic, ir a la URL
  marker.events.register('mousedown', marker, function(evt) { 
    window.location = url;
    OpenLayers.Event.stop(evt); 
  });
  
  // Añadimos el icono a la capa de markers
  markers.addMarker(marker);
}

