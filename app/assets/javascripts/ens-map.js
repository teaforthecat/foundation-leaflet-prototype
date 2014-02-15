var cloudmadeUrl = 'http://{s}.tile.cloudmade.com/BC9A493B41014CAABB98F0471D759707/997/256/{z}/{x}/{y}.png'
var cloudmade = new L.TileLayer(cloudmadeUrl, {maxZoom: 15});

// var center = L.latLngBounds(southWest, northEast).getCenter();
window.map = new L.Map('map', {layers: [cloudmade],
                               // TODO: use current location for default latLng
                               center: new L.LatLng(-37.7772, 175.2756),
                               zoom: 10 });

L.Icon.Default.imagePath = '/assets';

// global
if ( $('#currentGeoObject').data( 'geo' ) ) {
    geojsony = $('#currentGeoObject').data( 'geo' );
    var editableLayers = L.geoJson(geojsony).addTo(window.map);
    window.searchValue = geojsony.properties.search_value || "City: ";
    var mapBounds = geojsony.properties.map_bounds;
    var sw_lat = parseFloat(mapBounds._southWest.lat);
    var sw_lng = parseFloat(mapBounds._southWest.lng);
    var ne_lat = parseFloat(mapBounds._northEast.lat);
    var ne_lng = parseFloat(mapBounds._northEast.lng);

    window.map.fitBounds([
        [sw_lat, sw_lng],
        [ne_lat, ne_lng]
    ]);
} else {
    var editableLayers = new L.FeatureGroup();
    window.searchValue = "City: ";
}


options = function(editableLayers) {
    return {
        position: 'topright',
        draw: {
            //use default rectangle only
            // rectangle: {
            //     shape_options: {
            //     color: "something"
            //     },
            // },
            polygon: false,
            polyline: false,
            circle: false,
            marker: false
        },
        edit: {
            featureGroup: editableLayers, //REQUIRED!!
            //layers are cleared when a shape is drawn
            // and a map should not be valid without a shape
            // so don't allow to delete a shape
            remove: false
        }
    };
};

var drawControl = new L.Control.Draw(options(editableLayers));
map.addControl(drawControl);

search_layer = new L.Control.GeoSearch({
    provider: new L.GeoSearch.Provider.OpenStreetMap(),
    position: 'bottomleft',
    searchLabel: window.searchValue, // set to saved or default value above
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
            },
            'json'
          );

    editableLayers.addLayer(layer);
};


function build_json(layer) {
    // GeoSearch plugin:
    // val() will exist only if it was edited
    var search_value = $('#leaflet-control-geosearch-qry').val();
    // the placeholder is set by the plugin
    // we need to store it on the page or it will get overwritten when saving the geojson
    placeholder = $('#leaflet-control-geosearch-qry').attr('placeholder');
    // don't save the default placeholder
    real_search_value = search_value || ((placeholder == 'City: ') ? "" : placeholder );

    //global map
    var map_bounds = map.getBounds();
    var zoom = map.getZoom();
    var geoJson = layer.toGeoJSON();
    // console.log('geo out')
    // console.log(geoJson.geometry);
    var geo = $.extend(true, {}, geoJson,
                       { properties: { search_value: real_search_value,
                                       map_bounds: map_bounds}});

    // TODO: the coordinates array seems to be converted into an object
    // in the form_vars of the request, it would be better if the coordinates
    // were kept in an array of arrays
    // purge functions
    return JSON.parse(JSON.stringify(geo));
}

map.on('draw:created', function(e){
    drawnItemHandler( e.layer );
});


// only one shape allowed
map.on('draw:drawstart', function(e){
    editableLayers.clearLayers();
})

map.on('draw:edited', function(e){
    // we have the luxury of using the first editableLayer
    // because we limit the number of layers to one by clearLayers
    // in drawstart
    drawnItemHandler( editableLayers.getLayers()[0] );
});
