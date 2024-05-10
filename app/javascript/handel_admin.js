$(document).ready(function () {
  $(".submit-btn").on("click", function (e) {
    e.preventDefault();
    admin = {
      name: $("#admin-name").val(),
      email: $("#admin-email").val(),
      password: $("#admin-password").val(),
    };

    console.log(admin);
    $.ajax({
      url: "http://localhost:3000/admins",
      method: "POST",
      data: admin,
      dataType: "html",
      success: function (result) {
        console.log(result);
        $("#all_admin").append(result);
      },
    });
  });
});
