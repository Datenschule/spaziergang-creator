document.addEventListener('DOMContentLoaded', () => {
    mapboxgl.accessToken = 'pk.eyJ1Ijoib2tmZGUiLCJhIjoiY2prbXBqYmN3MDlqeTN3cWw3d29iN3N6diJ9.3gsuGnBGg7Z67XxRFNLalA';

    // station#show
    // just displaying a marker
    let smallMap = document.querySelector('#small-map');
    if (smallMap) {
        let markerCoord = [smallMap.dataset.lon, smallMap.dataset.lat];
        let map = createMap(smallMap, markerCoord, 12);

        var marker = new mapboxgl.Marker()
            .setLngLat(markerCoord)
            .addTo(map);
    }

    // station#edit
    // draggble pin and geocoding for forms
    let pickMap = document.querySelector('#pick-map');
    if (pickMap) {
        let input_lon = document.querySelector('#station_lon');
        let input_lat = document.querySelector('#station_lat');

        let map = createMap(pickMap, [input_lon.value, input_lat.value], 11);

        let marker = new mapboxgl.Marker({draggable: true})
            .setLngLat([input_lon.value, input_lat.value])
            .addTo(map);

        let geocoder = new MapboxGeocoder({
            accessToken: mapboxgl.accessToken
        });
        map.addControl(geocoder);

        map.on('load', function() {
            geocoder.on('result', function(ev) {
                input_lon.value = ev.result.geometry.coordinates[0];
                input_lat.value = ev.result.geometry.coordinates[1];
                marker.setLngLat(ev.result.geometry.coordinates);
            });
        });

        marker.on('dragend', function() {
            let lnglat = marker.getLngLat();
            input_lon.value = lnglat.lng;
            input_lat.value = lnglat.lat;
        });
    }

    // walk#show
    // display marker for every station in walk
    let bigMap = document.querySelector("#big-map");
    if (bigMap) {
        let map = createMap(bigMap, [13.412926552785137, 52.521722799795555], 14);
        createListOfMarkers(map);
        map.on('load', function () {
            let geoCoords = [].concat.apply([], JSON.parse(bigMap.dataset.courseline));
            addLineLayer(map, geoCoords, "LineString");
        });
    }

    // walk#courseline
    // marker for every station
    let routeMap = document.querySelector("#route-map");
    if (routeMap) {
        let map = createMap(routeMap, [13.412926552785137, 52.521722799795555], 14);
        createListOfMarkers(map);

        map.on('mousemove', ev => {
            if (document.querySelector('.station-list-item.bg-success')) {
                document.querySelector('.map-coord-info').innerHTML = JSON.stringify(ev.lngLat);
            } else {
                document.querySelector('.map-coord-info').innerHTML = "Mark a station first";
            }
        });

        map.on('click', ev => {
            let activeStation = document.querySelector('.station-list-item.bg-success');
            if (activeStation) {
                new mapboxgl.Marker().setLngLat(ev.lngLat).addTo(ev.target);
                let field = document.createElement('li');
                field.innerHTML = [ev.lngLat.lng, ev.lngLat.lat];
                activeStation.children[1].appendChild(field);
            }
        });

        map.on('load', function () {
            let geoCoords = [].concat.apply([], JSON.parse(routeMap.dataset.courseline));
            addLineLayer(map, geoCoords, "Point");
        });

        // activate station
        let markers = document.querySelectorAll('.marker');
        let listItems = document.querySelectorAll('.station-list-item');
        listItems.forEach((v, i) => {
            if (i !== listItems.length -1) { // not for last item in list
                v.addEventListener('click', (e) => {
                    listItems.forEach(x => {x.classList.remove('bg-success')});
                    markers.forEach(x => {x.classList.remove('active')});
                    v.classList.add('bg-success');
                    document.querySelector(`.marker[data-station="${v.dataset.station}"]`).classList.add('active');
                });
            }
        });
    }
});

function addLineLayer(map, coords, style) {
    map.addLayer({
        "id": "route",
        "type": "line",
        "source": {
            "type": "geojson",
            "data": {
                "type": "Feature",
                "properties": {},
                "geometry": {
                    "type": style,
                    "coordinates": coords
                }
            }
        },
        "layout": {
            "line-join": "miter",
            "line-cap": "square"
        },
        "paint": {
            "line-color": "#5500c3",
            "line-width": 5
        }
    });
}


function createListOfMarkers(map) {
    let coords = document.querySelectorAll('.station-list-item');

    coords.forEach((v, i) => {
        let el = document.createElement('div');
        el.classList.add('marker');
        el.dataset.station = v.dataset.station;
        new mapboxgl.Marker(el)
            .setLngLat([v.dataset.lon, v.dataset.lat])
            .addTo(map);
        if (i === 0) {
            map.setCenter([v.dataset.lon, v.dataset.lat]);
        }
    });
}

function createMap(id, coordArray, zoom) {
    return new mapboxgl.Map({
        container: id,
        style: 'mapbox://styles/okfde/cjhhp085v001u2rqh82cj1x6p',
        center: coordArray,
        zoom: zoom
    });
}
