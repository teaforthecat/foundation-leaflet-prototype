var cloudmadeUrl = 'http://{s}.tile.cloudmade.com/BC9A493B41014CAABB98F0471D759707/997/256/{z}/{x}/{y}.png',
    cloudmade = new L.TileLayer(cloudmadeUrl, {maxZoom: 18}),
    map = new L.Map('map', {layers: [cloudmade], center: new L.LatLng(-37.7772, 175.2756), zoom: 15 });

L.Icon.Default.imagePath = '/assets';

var editableLayers = new L.FeatureGroup();
map.addLayer(editableLayers);


// default values. for example only.
// var MyCustomMarker = L.Icon.extend({
//     options: {
//         iconUrl: '/assets/marker-icon'+ (L.Browser.retna ? '-2x': '') +'.png', //TODO: handle retna?
//         shadowUrl: '/assets/marker-shadow.png',
//         shadowSize: [41, 41],
//         iconAnchor: [12, 41],
//         iconSize: [25, 41],
//         popupAnchor: [1, -34]
//     }
// });

var options = {
    position: 'topright',
    draw: {
        polyline: undefined,

        // polyline: {
        //     shapeOptions: {
        //         color: '#f357a1',
        //         weight: 10
        //     }
        // },
        polygon: {
            allowIntersection: false, // Restricts shapes to simple polygons
            drawError: {
                color: '#e1e100', // Color the shape will turn when intersects
                message: '<strong>Oh snap!<strong> you can\'t draw that!' // Message that will show when intersect
            },
            shapeOptions: {
                color: '#bada55'
            }
        },
        circle: undefined,
        rectangle: undefined,
        marker: undefined
        // note that geoJSON spec does not support circles
        // however- pointToLayer option and turning point features into circles, using the radius from feature.properties.
        // circle: false, // Turns off this drawing tool
        // rectangle: {
        //     shapeOptions: {
        //         clickable: false
        //     }
        // },
        // marker: {
        //     icon: new MyCustomMarker()
        // }
    },
    edit: {
        featureGroup: editableLayers, //REQUIRED!!
        remove: true
    }
};

var drawControl = new L.Control.Draw(options);
map.addControl(drawControl);

map.on('draw:created', function (e) {
    var type = e.layerType,
        layer = e.layer;

    if (type === 'marker') {
        layer.bindPopup('A popup!');
    }

    editableLayers.addLayer(layer);
});



map.on('draw:created', function (e) {
    var type = e.layerType,
        layer = e.layer;

    console.log( e  );
    console.log( JSON.stringify(layer.toGeoJSON()) );
    console.log( L.stamp(layer) );
    if (type === 'marker') {
        console.log("hi");
    }

    console.log("hello");
    // Do whatever else you need to. (save to db, add to map etc)

    map.addLayer(layer);
});


search_layer = new L.Control.GeoSearch({
    provider: new L.GeoSearch.Provider.OpenStreetMap(),
    position: 'bottomleft',
    searchLabel: "City:",
    zoomLevel:  10,
    onRemove: function(){},
}).addTo(map);


map.addLayer(search_layer);
