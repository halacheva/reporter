$(document).on("page:load", function() {
  $(document).data("inProgress", false);

  $("a[rel^='prettyPhoto[mixed]']").prettyPhoto({
    theme: "dark_rounded",
    deeplinking: false,
    social_tools: false
  });

  // initialize because of turbolinks
  $('.rateit').rateit();
  $('#rate_it').on('rated reset', function (e) {
       var ratingTool = $(this);
       var value = ratingTool.rateit('value');
       var reportID = ratingTool.data('report-id');

       $.ajax({
           url: '/reports/' + reportID + '/rate',
           data: { report: { rating: value } },
           type: 'POST',
           success: function (data) {
              ratingTool.data('rateit-value', data.rating);
           }
       });
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
