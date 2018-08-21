document.addEventListener('DOMContentLoaded', () => {
  let routeMap = document.querySelector("#route-map");
  let initLoader = document.querySelector("#course-initial-load");
  let courseApp = document.querySelector("#course-app-section");
  let courseActivateInfo = document.querySelector("#course-activate-info");

  if (routeMap && courseApp) {
    courseApp.classList.add('d-none');

    let map = createMap(routeMap, [13.412926552785137, 52.521722799795555], 14);
    createListOfMarkers(map);
    let clearButton = document.querySelector('#courseline-clear');
    if (clearButton) {
      clearButton.addEventListener('click', clearLines);
    }

    map.on('mousemove', ev => {
      if (document.querySelector('.station-list-item.active')) {
        courseActivateInfo.classList.add('d-none');
      } else {
        courseActivateInfo.classList.remove('d-none');
      }
    });

    map.on('click', ev => {
      let activeStation = document.querySelector('.station-list-item.active');
      if (activeStation) {
        new mapboxgl.Marker(createMiniMarker(activeStation))
          .setLngLat(ev.lngLat).addTo(ev.target);
        writeCoordsToDOM(activeStation, ev.lngLat);
        showStationClearButton(activeStation);
      }
    });

    map.on('load', function () {
      courseApp.classList.remove('d-none');
      initLoader.classList.add('d-none');

      let markers = document.querySelectorAll('.marker');
      let listItems = document.querySelectorAll('.station-list-item');
      let layerArray = collectAndRenderGeoLayers();
      let mapLayers = collectLayerNames(layerArray, markers);

      let stationClearButtons = document.querySelectorAll('.clear-station-btn');
      if (stationClearButtons) {
        stationClearButtons.forEach(x => { x.addEventListener('click', clearLine); });
      }

      listItems.forEach((stationItem, i) => {
        stationItem.classList.add('ready');
        hideStationClearButton(stationItem);

        if (i !== 0) { // first station never has a course line
          stationItem.addEventListener('click', (e) => {
            courseActivateInfo.classList.add('d-none');

            paintLayersDefault(mapLayers);
            [listItems, markers].forEach(collection => {
              resetActiveOnCollection(collection);
            });
            setActiveListItemMarkerLayer(stationItem);
            setStartSignalMarker(listItems[i - 1]);
          });
        }
      });
    });

    function showStationClearButton(station) {
      if (station.children[1].children.length > 0
          && station.children[0].children.length > 1) {
        station.children[0].children[1].classList.remove('d-none');
      }
    }

    function hideStationClearButton(station) {
      if (station.children[1].children.length == 0
          && station.children[0].children.length > 1) {
        station.children[0].children[1].classList.add('d-none');
      }
    }

    function setStartSignalMarker(stationItem) {
      let station_id = stationItem.dataset.station;
      stationItem.classList.add('start-active');
      document.querySelector(`.marker[data-station="${station_id}"]`).classList.add('start-active');
    }

    function setActiveListItemMarkerLayer(stationItem) {
      let station_id = stationItem.dataset.station;
      let layer_id = `route-${stationItem.dataset.priority}`;
      stationItem.classList.add('active');
      document.querySelector(`.marker[data-station="${station_id}"]`).classList.add('active');
      if (map.getLayer(layer_id)) {
        map.setPaintProperty(layer_id,'line-color', "#00ff9d");
      }
    }

    function resetActiveOnCollection(collection) {
      collection.forEach(x => {
        x.classList.remove('active');
        x.classList.remove('start-active');
      });
    }

    function paintLayersDefault(mapLayers) {
      if (mapLayers) {
        mapLayers.forEach(x => {
          if (map.getLayer(x)) {
            map.setPaintProperty(x, 'line-color', "#5500c3");
          }
        });
      }
    }

    function collectAndRenderGeoLayers() {
      layerArray = [];
      if (routeMap.dataset.courseline !== '') {
        layerArray = JSON.parse(routeMap.dataset.courseline);
        //debugger
        layerArray.forEach((x, i) => { addLineLayer(map, x, `route-${i + 1}`) }); // match station priority
      }
      return layerArray;
    }

    function collectLayerNames(layerArray, markers) {
      let mapLayers = [];
      if (layerArray) {
        for(let i = 0; i < markers.length; i++) {
          mapLayers.push(`route-${i}`);
        }
      }
      return mapLayers;
    }

    function clearLine(ev) {
      let station = ev.target.parentNode.parentNode;
      let layer_id = `route-${station.dataset.priority}`;
      let list = station.children[1];
      let markers = document.querySelectorAll(`.mini-marker[data-station="${station.dataset.station}"]`);
      while(list.firstChild) {
        list.removeChild(list.firstChild);
      }
      markers.forEach(x => {x.remove();});

      if (map.getLayer(layer_id)) {
        map.removeLayer(layer_id);
      }
    }

    function clearLines(ev) {
      document.querySelectorAll('.station-list-item ol').forEach(x => {
        map.removeLayer('route-'+ x.parentElement.dataset.priority);
        while(x.firstChild) {
          x.removeChild(x.firstChild);
        }
      });
    }

    function createMiniMarker(station) {
      let el = document.createElement('div');
      el.classList.add('mini-marker');
      el.dataset.station = station.dataset.station;
      return el;
    }

    function writeCoordsToDOM(station, coords) {
      let field = document.createElement('li');
      field.innerHTML = [coords.lng, coords.lat];
      station.children[1].appendChild(field);
    }
  }
});
