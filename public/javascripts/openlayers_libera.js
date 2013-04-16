var map;
var markers;
function openlayers_map() {
    //Creamos el mapa con la capa de OSM
    map = new OpenLayers.Map('map');
    layer = new OpenLayers.Layer.OSM( "Simple OSM Map");
    map.addLayer(layer);
    
    // Centramos el mapa en Vitoria
    center_map(-2.68261, 42.843578)
    
    // Añadimos una capa de Markers
    markers = new OpenLayers.Layer.Markers( "Markers" );
    map.addLayer(markers);
    
    // Cargamos cada uno de los puntitos para las bicicletas
    // Esta función es generada en tiempo real dentro del HTML
    cargar_markers_bicicletas();
}


function center_map(longitude, latitude) {
  var foundPosition = new OpenLayers.LonLat(longitude, latitude).transform(
    new OpenLayers.Projection("EPSG:4326"),
    map.getProjectionObject()
  );
  map.setCenter(foundPosition, 7);
}


function add_marker(longitude, latitude, color, url) {
  var foundPosition = new OpenLayers.LonLat(longitude, latitude).transform(
    new OpenLayers.Projection("EPSG:4326"),
    map.getProjectionObject()
  );

  // Creamos el icono
  var size = new OpenLayers.Size(21,25);
  var offset = new OpenLayers.Pixel(-(size.w/2), -size.h);
  var icon = new OpenLayers.Icon('/javascripts/img/marker-'+ color +'.png', size, offset);
  marker = new OpenLayers.Marker(foundPosition,icon);
  
  // Al hacer clic, ir a la URL
  marker.events.register('mousedown', marker, function(evt) { 
    window.location = url;
    OpenLayers.Event.stop(evt); 
  });
  
  // Añadimos el icono a la capa de markers
  markers.addMarker(marker);
}

