$(document).ready(function () {
  $(".remove-skill-btn").on("click", function (e) {
    e.preventDefault();

    var deleteButton = $(this);
    var skillId = $(this).data("skill");
    var cur_url = `http://localhost:3000/skills/${skillId}`;
    console.log(skillId);

    $.ajax({
      url: cur_url,
      method: "DELETE",
      dataType: "html",
      processData: false,
      contentType: false,
      success: function (result) {
        deleteButton.closest("div.card.skill").remove();
        console.log("Skill removed successfully.");
      },
      error: function () {
        console.log("Failed to remove skill.");
      },
    });
  });
});
