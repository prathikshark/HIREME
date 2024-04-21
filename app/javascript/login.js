document.addEventListener('DOMContentLoaded', function() {
    var workerLink = document.getElementById('login-worker-link');
    var customerLink = document.getElementById('login-customer-link');

    workerLink.addEventListener('click', function(event) {
      event.preventDefault();
      workerLink.style.display = 'none';
      customerLink.style.display = 'inline';
    });

    customerLink.addEventListener('click', function(event) {
      event.preventDefault(); 
      customerLink.style.display = 'none';
      workerLink.style.display = 'inline';
    });
  });
