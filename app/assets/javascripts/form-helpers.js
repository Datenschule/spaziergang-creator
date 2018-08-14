document.addEventListener('DOMContentLoaded', () => {
    let variantRadios = document.querySelectorAll(".variant-radio");
    let variantForms = document.querySelectorAll('.radio-additional');

    if (variantRadios) {
        function toggleVariantForms(ev) {
            variantForms.forEach(v => v.classList.add('d-none'));
            let variant = ev.target.value;
            document.querySelector(`[data-${variant}]`).classList.remove('d-none');
        }
        variantRadios.forEach((v) => {
            v.addEventListener('change', toggleVariantForms);
        });
    }
});
