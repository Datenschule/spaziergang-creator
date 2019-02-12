// close button on notifications
document.addEventListener('DOMContentLoaded', () => {
  let list = document.querySelector('#sortable-list');
  let saveButton = document.querySelector('#sortable-save');
  let saveStatus = document.querySelector('#sortable-saving');
  let orderStatus = document.querySelector('#sortable-order-changed');
  let orderError = document.querySelector('#sortable-order-error');

  if (list && saveButton) {

    saveButton.addEventListener('click', () => sendUpdatedOrder());

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
      saveStatus.classList.remove('d-none');
      saveButton.classList.add('d-none');
      orderError.classList.add('d-none');
      fetch(window.location.pathname, {
        method: 'PUT',
        headers: {
          'Origin': window.location.origin,
          'Content-Type': 'application/json',
          'X-CSRF-Token': grabCSRF(),
          'X-Requested-With': 'XMLHttpRequest',
          'Accept': 'application/json'
        },
        credentials: "same-origin",
        body: JSON.stringify({data: setUpdatedOrder()})
      }).then(resp => {
          if (resp.status === 200) {
            setTimeout(() => {
              saveStatus.classList.add('d-none');
              saveButton.classList.remove('d-none');
              orderStatus.classList.add('d-none');
            }, 500);
          } else {
            setTimeout(() => {
              saveStatus.classList.add('d-none');
              saveButton.classList.remove('d-none');
              orderStatus.classList.add('d-none');
              orderError.classList.remove('d-none');
            });
          }
        })
        .catch(error => console.log(`Fetch Error ${error}`));
    }

    setPositions();

    let sortable = Sortable.create(list, {
      onEnd(evt) {
        setPositions();
        orderStatus.classList.remove('d-none');
      }
    });
  }
});
