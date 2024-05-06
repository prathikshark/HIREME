$(document).ready(function() {
    $('.approve-btn').click(function() {
      var workerId = $(this).data('worker-id');
      $.ajax({
        url: '/workers/' + workerId + '/approve',
        type: 'PATCH',
        success: function(response) {
          $("#worker-table-id")
          console.log('Worker status updated to approved');
        }
      });
    });
  });
  
  
  
  $(document).ready(function() {
    $('.reject-btn').click(function() {
      var workerId = $(this).data('worker-id');
      $.ajax({
        url: '/workers/' + workerId + '/reject',
        type: 'PATCH',
        success: function(response) {
          $("#worker-table-id")
          console.log('Worker status updated to reject');
        }
      });
    });
  });