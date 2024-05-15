$(document).ready(function () {
  $(".remove-customer-btn").on("click", function (e) {
    e.preventDefault();

    var deleteButton = $(this);
    var customerId = $(this).data("customer");
    var cur_url = `http://localhost:3000/customers/${customerId}`;
    console.log(cur_url);
    $.ajax({
      url: cur_url,
      method: "DELETE",
      dataType: "html",
      processData: false,
      contentType: false,
      success: function (result) {
        deleteButton.closest("div.card-body").remove();
        console.log("Customer removed successfully.");
      },
      error: function () {
        console.log("Failed to remove customer.");
      },
    });
  });
});
