// close button on notifications
document.addEventListener('DOMContentLoaded', () => {
    let saveButton = document.querySelector('#courseline-save');
    let saveStatus = document.querySelector('#courseline-saving');

    if (saveButton) {
        saveButton.addEventListener('click', sendUpdatedOrder);

        function grabCSRF() {
            return document.querySelector('meta[name="csrf-token"]').content;
        }

        function populateData() {
            let data = [];
            document.querySelectorAll('.station-list-item').forEach((v, i) => {
                let station = {};
                station.id = v.dataset.station;
                station.priority = v.dataset.priority;
                station.coords = new Array();
                if (v.children[1].childNodes.length > 0) {
                    station.coords.push([v.dataset.lon, v.dataset.lat]);
                    v.children[1].childNodes.forEach(v => {
                        let lngLat = v.textContent.split(',');
                        if (lngLat && lngLat.length == 2) {
                            station.coords.push([lngLat[0], lngLat[1]]);
                        }
                    });
                }

                data.push(station);
            });
            data.forEach((x, i) => {
                if (i < data.length -1 && x.coords.length > 0) {
                    x.coords.push(data[i + 1].coords[0]);
                }
            });
            return data;
        }

        function sendUpdatedOrder() {
            saveButton.classList.add('d-none');
            saveStatus.classList.remove('d-none');
            fetch(window.location.pathname, {
                method: 'PUT',
                headers: {
                    'Content-Type': 'application/json',
                    'X-CSRF-Token': grabCSRF(),
                    'X-Requested-With': 'XMLHttpRequest',
                    'Accept': 'application/json'
                },
                credentials: "same-origin",
                body: JSON.stringify({data: populateData()})
            })
                .then(resp => {
                    saveButton.classList.remove('d-none');
                    saveStatus.classList.add('d-none');
                    window.location.reload();
                })
                .catch(error => console.log(`Fetch Error ${error}`));
        }
    }
});
