document.addEventListener('DOMContentLoaded', () => {
    let smallMap = document.querySelector('#small-map');

    if (smallMap) {
        let markerCoord = [smallMap.dataset.lat, smallMap.dataset.lon];
        let mapObj = L.map('small-map').setView(markerCoord, 14);
        L.tileLayer(
            'https://api.tiles.mapbox.com/v4/{id}/{z}/{x}/{y}.png?access_token={accessToken}', {
                attribution: 'Map data &copy; <a href="https://www.openstreetmap.org/">OpenStreetMap</a> contributors, <a href="https://creativecommons.org/licenses/by-sa/2.0/">CC-BY-SA</a>, Imagery © <a href="https://www.mapbox.com/">Mapbox</a>',
                maxZoom: 18,
                id: 'mapbox.streets',
                accessToken: 'pk.eyJ1Ijoib2tmZGUiLCJhIjoiY2prbXBqYmN3MDlqeTN3cWw3d29iN3N6diJ9.3gsuGnBGg7Z67XxRFNLalA'
            }).addTo(mapObj);
        let marker = L.marker(markerCoord).addTo(mapObj);
    }
});
