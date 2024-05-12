$(document).ready(function () {
    $(".remove-service-btn").on("click", function (e) {
      e.preventDefault();
  
      var deleteButton = $(this);
      var serviceId = $(this).data("service");
      var cur_url = `http://localhost:3000/booked_services/${serviceId}`;
      console.log(deleteButton);
  
      $.ajax({
        url: cur_url,
        method: "DELETE",
        dataType: "html",
        processData: false,
        contentType: false,
        success: function (result) {
          deleteButton.closest("div.cart-item").remove();
          console.log("Service removed successfully.");
        },
        error: function () {
          console.log("Failed to remove Service.");
        },
      });
    });
});