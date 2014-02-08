// if ($('#geojson-serialized')) {
//    console.log( $('#geojson-serialized').value);
// }

geojsony = {
    "properties": {},
    "type": "Feature",
    "geometry": {
        "type": "Polygon",
        "coordinates": [
            [
                [
                    175.2847623825073,
                    -37.77495501866911
                ],
                [
                    175.2933883666992,
                    -37.77298755890846
                ],
                [
                    175.29175758361816,
                    -37.779398571318765
                ],
                [
                    175.28845310211182,
                    -37.78075532805877
                ],
                [
                    175.2847623825073,
                    -37.77495501866911
                ]
            ]
        ]
    }
}



var cloudmadeUrl = 'http://{s}.tile.cloudmade.com/BC9A493B41014CAABB98F0471D759707/997/256/{z}/{x}/{y}.png'
var cloudmade = new L.TileLayer(cloudmadeUrl, {maxZoom: 18});




geo_layer = L.geoJson(geojsony);
// geo_layer = L.GeoJson.geometryToLayer(geojsony); older version perhaps

window.map = new L.Map('map', {layers: [cloudmade], center: new L.LatLng(-37.7772, 175.2756), zoom: 15 });

L.Icon.Default.imagePath = '/assets';

var editableLayers = L.geoJson(geojsony).addTo(window.map);


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
    }; };
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

function drawnItemHandler (layer){
    var geo_path = $('#map').data('geo-path');
    // var sse_channel = $('#map').data('sse-channel');
    var really_json = build_json(layer)


    $.post( geo_path,
            {geo: {geojson: really_json}},
             // sse_channel: sse_channel},
            function(response){
                //message?
                console.log(response)
            }
          );

    editableLayers.addLayer(layer);
};


function build_json(layer) {
    // GeoSearch plugin:
    var search_value = $('#leaflet-control-geosearch-qry').value;
    //global map
    var map_bounds = map.getBounds();
    var geoJson = layer.toGeoJSON();
    var geo = $.extend(true, {}, geoJson,
                       { properties: { search_value: search_value,
                                       map_bounds: map_bounds}});
    // purge functions
    return JSON.parse(JSON.stringify(geo));
 }

map.on('draw:created', function(e){ drawnItemHandler( e.layer ); });
map.on('draw:edited', function(e){ e.layers.eachLayer( drawnItemHandler ); });
// map.on('draw:deleted', function(e){ deletedItemHandler(e.layer) });


                // drawControl.removeFrom(map);
                // coords = response.geometry.coordinates;
                // response_layer = L.Polygon(coords);
                // console.log(response_layer);

                // editableLayers2 = new L.FeatureGroup();
                // map.addLayer(editableLayers2);

                // // editableLayers.addLayer(response_layer);
                // // geo_layer = L.geoJson(response);
                // response_poly = L.
                // editableLayers.addLayer(geo_layer);

                // // reinitialize editableLayers

                // // drawControl.addTo(map);
                // //overwrite variable
                // drawControl = new L.Control.Draw(options(editableLayers));
                // map.addControl(drawControl);
