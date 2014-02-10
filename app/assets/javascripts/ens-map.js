var cloudmadeUrl = 'http://{s}.tile.cloudmade.com/BC9A493B41014CAABB98F0471D759707/997/256/{z}/{x}/{y}.png'
var cloudmade = new L.TileLayer(cloudmadeUrl, {maxZoom: 15});

// var center = L.latLngBounds(southWest, northEast).getCenter();
window.map = new L.Map('map', {layers: [cloudmade],
                               center: new L.LatLng(-37.7772, 175.2756),
                               zoom: 15 });

L.Icon.Default.imagePath = '/assets';

// global
if ( $('#currentGeoObject').data( 'geo' ) ) {
    geojsony = $('#currentGeoObject').data( 'geo' );
    console.log( geojsony );
    var editableLayers = L.geoJson(geojsony).addTo(window.map);
    console.log(editableLayers);
} else {
    var editableLayers = new L.FeatureGroup();
}


options = function(editableLayers) {
    return {
        position: 'topright',
        draw: {

            // rectangle: {
            //     shape_options: {
            //     color: "something"
            // }
            // },
            //use default rectangle only
            // polygon: false,
            polyline: false,
            circle: false,
            marker: false
        },
        edit: {
            featureGroup: editableLayers, //REQUIRED!!
            remove: true
        }
    };
};

var drawControl = new L.Control.Draw(options(editableLayers));
map.addControl(drawControl);

search_layer = new L.Control.GeoSearch({
    provider: new L.GeoSearch.Provider.OpenStreetMap(),
    position: 'bottomleft',
    searchLabel: "City:",
    zoomLevel:  10
    //    onRemove: function(){},
}).addTo(map);


map.addLayer(search_layer);


// handlers

function drawnItemHandler (layer){
    var geo_path = $('#map').data('geo-path');
    // var sse_channel = $('#map').data('sse-channel');
    var really_json = build_json(layer)


    $.post( geo_path,
            {geo: {geojson: really_json}},
            // sse_channel: sse_channel},
            function(response){
                var jacked = humane.create({
                    baseCls: 'humane-jackedup',
                    addnCls: 'humane-jackedup-success' });
                jacked.log("Saved!");
            }
          );

    editableLayers.addLayer(layer);
};


function build_json(layer) {
    // GeoSearch plugin:
    var search_value = $('#leaflet-control-geosearch-qry').value;
    //global map
    var map_bounds = map.getBounds();
    var zoom = map.getZoom();
    var geoJson = layer.toGeoJSON();
    var geo = $.extend(true, {}, geoJson,
                       { properties: { search_value: search_value,
                                       map_bounds: map_bounds,
                                       zoom: zoom}});
    // purge functions
    return JSON.parse(JSON.stringify(geo));
}

map.on('draw:created', function(e){
    drawnItemHandler( e.layer );
});

// map.on('draw:edited', function(e){ e.layers.eachLayer( drawnItemHandler ); });
// map.on('draw:deleted', function(e){ deletedItemHandler(e.layer) });
