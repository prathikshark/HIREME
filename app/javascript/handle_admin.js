
$(document).ready(function () {
  $(".submit-btn").on("click", function (e) {
    e.preventDefault(e);
        console.log($(".submit-btn"));

    let admin = {
      user: {
        name: $(".admin-name").val(),
        email: $(".admin-email").val(),
        password: $(".admin-password").val()
      }
    };

    $.ajax({
      url: "http://localhost:3000/admins",
      method: "POST",
      data: admin,
      dataType: "html",
      success: function (result) {
        console.log(result);
        $("#all_admin").append(result);
      }
    });
  });
});
