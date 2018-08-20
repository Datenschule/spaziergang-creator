document.addEventListener('DOMContentLoaded', () => {
    mapboxgl.accessToken = 'pk.eyJ1Ijoib2tmZGUiLCJhIjoiY2prbXBqYmN3MDlqeTN3cWw3d29iN3N6diJ9.3gsuGnBGg7Z67XxRFNLalA';

    // walk#courseline
    // marker for every station
    let routeMap = document.querySelector("#route-map");
    if (routeMap) {

        let clearButton = document.querySelector('#courseline-clear');
        if (clearButton) {
            clearButton.addEventListener('click', clearLines);
        }

        function clearLines(ev) {
            document.querySelectorAll('.station-list-item ol').forEach(x => {
                map.removeLayer('route-'+ x.parentElement.dataset.priority);
                while(x.firstChild) {
                    x.removeChild(x.firstChild);
                }
            });
        }

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
                let el = document.createElement('div');
                el.classList.add('mini-marker');
                new mapboxgl.Marker(el).setLngLat(ev.lngLat).addTo(ev.target);
                let field = document.createElement('li');
                field.innerHTML = [ev.lngLat.lng, ev.lngLat.lat];
                activeStation.children[1].appendChild(field);
            }
        });

        map.on('load', function () {
            let layerArray = false;
            if (routeMap.dataset.courseline !== '') {
                layerArray = JSON.parse(routeMap.dataset.courseline);
                layerArray.forEach((x, i) => { addLineLayer(map, x, `route-${i}`) }); // match station id
            }

            // activate station
            let markers = document.querySelectorAll('.marker');
            let listItems = document.querySelectorAll('.station-list-item');
            let mapLayers = [];
            if (layerArray) {
                for(let i = 0; i < markers.length; i++) {
                    mapLayers.push(`route-${i}`);
                }
            }
            listItems.forEach((v, i) => {
                if (i !== listItems.length -1) { // not for last item in list
                    v.addEventListener('click', (e) => {
                        if (layerArray) {
                            mapLayers.forEach(x => { map.setPaintProperty(x, 'line-color', "#5500c3");});
                        }
                        listItems.forEach(x => {x.classList.remove('bg-success')});
                        markers.forEach(x => {x.classList.remove('active')});
                        v.classList.add('bg-success');
                        document.querySelector(`.marker[data-station="${v.dataset.station}"]`).classList.add('active');
                        //debugger
                        if (layerArray) {
                            map.setPaintProperty(`route-${v.dataset.priority}`,'line-color', "#00ff9d");
                        }
                    });
                }
            });
        });
    }

});
