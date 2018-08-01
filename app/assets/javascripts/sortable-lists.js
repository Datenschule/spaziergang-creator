// close button on notifications
document.addEventListener('DOMContentLoaded', () => {
    let list = document.querySelector('#sortable-list');
    if (list) {
        function setPositions(){
            document.querySelectorAll('#sortable-list li').forEach((i, index) => {
                i.setAttribute('data-pos', index);
            });
        }

        function setUpdatedOrder() {
            let updatedOrder = [];
            document.querySelectorAll('#sortable-list li').forEach(i => {
                updatedOrder.push({ id: i.dataset.id, pos: i.dataset.pos });
            });
            return updatedOrder;
        }

        function grabCSRF() {
            return document.querySelector('meta[name="csrf-token"]').content;
        }

        function sendUpdatedOrder() {
            fetch(window.location.pathname, {
                method: 'PUT',
                headers: {
                    'Content-Type': 'application/json',
                    'X-CSRF-Token': grabCSRF(),
                    'X-Requested-With': 'XMLHttpRequest',
                    'Accept': 'application/json'
                },
                credentials: "same-origin",
                body: JSON.stringify({data: setUpdatedOrder()})
            })
                .then(resp => console.log(`List order updated`))
                .catch(error => console.log(`Fetch Error ${error}`));
        }

        setPositions();

        let sortable = Sortable.create(list, {
            onEnd(evt) {
                setPositions();
                sendUpdatedOrder();
            }
        });
    }
});
