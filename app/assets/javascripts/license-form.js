document.addEventListener('DOMContentLoaded', () => {
  var checkLicense = document.querySelector('.js-check-license input[type=checkbox]');
  var licenseText = document.querySelector('.js-license-text');
  var licenseSubmit = document.querySelector('.js-license-submit');

  if (checkLicense && licenseText && licenseSubmit) {
    checkLicense.addEventListener('change', function(e) {
      if (e.target.checked) {
        licenseText.classList.remove('is-hidden');
      } else {
        licenseText.classList.add('is-hidden');
      }
    })

    licenseSubmit.addEventListener('click', function(ev) {
      if (checkLicense.checked) {
        var confirmed = confirm(ev.target.dataset.prompt);
        if (confirmed) {
          return true;
        } else {
          ev.preventDefault();
          return false;
        }
      }
    })
  }
})
