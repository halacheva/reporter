$(document).on('ready', function() {
  $('.rating-link').on('ajax:success', function(e, data, status, xhr) {
    $('#rating').text(data.rating);
  });
});
