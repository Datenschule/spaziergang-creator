// close button on notifications
document.addEventListener('DOMContentLoaded', () => {
    let closeBtn = document.querySelector(".toast .btn");
    if (closeBtn) {
        closeBtn.addEventListener('click', (ev) => {
            ev.target.parentElement.remove();
        });
    } else {
        console.log("nope");
    }
});
