$(document).on("page:update", function() {
  $(document).data("inProgress", false);

  $(".rating-link").on("ajax:success", function(e, data, status, xhr) {
    $("#rating").text(data.rating);
  });

  $("a[rel^='prettyPhoto[mixed]']").prettyPhoto({
    theme: "dark_rounded",
    deeplinking: false,
    social_tools: false
  });
});

$(document).on("page:before-change", function() {
  $(document).data("inProgress", true);
  setTimeout(function () {
    if ($(document).data("inProgress")) {
      $(".fog").show();
    }
  }, 500);
});
