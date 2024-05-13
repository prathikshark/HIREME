$(document).ready(function () {
    $(".remove-worker-skill-btn").on("click", function (e) {
      e.preventDefault();
  
      var deleteButton = $(this);
      var workerSkillId = $(this).data("ws");
      var cur_url = `http://localhost:3000/worker_skills/${workerSkillId}`;
  
      $.ajax({
        url: cur_url,
        method: "DELETE",
        dataType: "html",
        processData: false,
        contentType: false,
        success: function (result) {
          deleteButton.closest("div.c").remove();
          console.log("worker skill removed successfully.");
        },
        error: function () {
          console.log("Failed to remove worker skill.");
        },
      });
    });
  });
  