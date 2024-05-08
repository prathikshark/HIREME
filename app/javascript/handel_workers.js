$(document).ready(function () {
  $(".approve-btn").click(function () {
    var workerId = $(this).data("worker-id");
    $.ajax({
      url: "/workers/" + workerId + "/approve",
      type: "PATCH",
      success: function (response) {
        $("#worker-table-id");
        console.log("Worker status updated to approved");
        $(document)
          .find(`[data-worker-id = ${workerId}]`)
          .closest(".worker-row")
          .remove();
      },
    });
  });
});

$(document).ready(function () {
  $(".reject-btn").click(function () {
    var workerId = $(this).data("worker-id");
    $.ajax({
      url: "/workers/" + workerId + "/reject",
      type: "PATCH",
      success: function (response) {
        $("#worker-table-id");
        console.log("Worker status updated to reject");
        $(document)
          .find(`[data-worker-id = ${workerId}]`)
          .closest(".worker-row")
          .remove();
      },
    });
  });
});

$(document).ready(function () {
  $("#add-worker-skill-btn").on("click", function (event) {
    event.preventDefault();

    worker_skill = {
      worker_skill: {
        id: $("#worker_skill_id option:selected").val(),
        wage: $("#worker-skill-wage").val(),
        experience: $("#worker-skill-experience").val(),
      },
    };

    console.log(worker_skill);
    $.ajax({
      url: "http://localhost:3000/worker_skills",
      method: "POST",
      data: worker_skill,
      dataType: "html",
      success: function (result) {
        $("#all-skills-of-worker").append(result);
      },
    });
  });
});
