document.addEventListener('DOMContentLoaded', () => {
    mapboxgl.accessToken = 'pk.eyJ1Ijoib2tmZGUiLCJhIjoiY2prbXBqYmN3MDlqeTN3cWw3d29iN3N6diJ9.3gsuGnBGg7Z67XxRFNLalA';

    // just displaying a marker
    let smallMap = document.querySelector('#small-map');
    if (smallMap) {
        let markerCoord = [smallMap.dataset.lon, smallMap.dataset.lat];
        let map = new mapboxgl.Map({
            container: 'small-map',
            style: 'mapbox://styles/okfde/cjhhp085v001u2rqh82cj1x6p',
            center: markerCoord,
            zoom: 12
        });

        var marker = new mapboxgl.Marker()
            .setLngLat(markerCoord)
            .addTo(map);
    }

    // draggble pin and geocoding for forms
    let pickMap = document.querySelector('#pick-map');
    if (pickMap) {
        let input_lon = document.querySelector('#station_lon');
        let input_lat = document.querySelector('#station_lat');

        let map = new mapboxgl.Map({
            container: 'pick-map',
            style: 'mapbox://styles/okfde/cjhhp085v001u2rqh82cj1x6p',
            center: [input_lon.value, input_lat.value],
            zoom: 11
        });

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

    let bigMap = document.querySelector("#big-map");
    if (bigMap) {
        let map = new mapboxgl.Map({
            container: 'big-map',
            style: 'mapbox://styles/okfde/cjhhp085v001u2rqh82cj1x6p',
            center: [13, 52],
            zoom: 12
        });

        document.querySelectorAll('.station-list-item').forEach((v, i) => {
            new mapboxgl.Marker()
                .setLngLat([v.dataset.lon, v.dataset.lat])
                .addTo(map);
            if (i === 0) {
                map.setCenter([v.dataset.lon, v.dataset.lat]);
            }
        });
    }
});
