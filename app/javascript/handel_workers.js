$(document).ready(function() {
    $('.approve-btn').click(function() {
      var workerId = $(this).data('worker-id');
      $.ajax({
        url: '/workers/' + workerId + '/approve',
        type: 'PATCH',
        success: function(response) {
          console.log('Worker status updated to approved');
        },
        error: function(xhr, status, error) {
          console.error('Error updating worker status:', error);
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
          console.log('Worker status updated to reject');
        },
        error: function(xhr, status, error) {
          console.error('Error updating worker status:', error);
        }
      });
    });
  });