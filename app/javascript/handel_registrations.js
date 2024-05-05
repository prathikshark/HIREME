document.addEventListener('DOMContentLoaded', function() {
    const workerRadio = document.getElementById('worker');
    const customerRadio = document.getElementById('customer');
    const workerForm = document.getElementById('worker-form');
    const customerForm = document.getElementById('customer-form');

    function showForm(show, hide) {
      show.style.display = 'block';
      hide.style.display = 'none';
    }

    function toggleForms() {
      if (workerRadio.checked) {
        showForm(workerForm, customerForm);
      } else if (customerRadio.checked) {
        showForm(customerForm, workerForm);
      }
    }

    workerRadio.addEventListener('change', toggleForms);
    customerRadio.addEventListener('change', toggleForms);

    toggleForms();
});