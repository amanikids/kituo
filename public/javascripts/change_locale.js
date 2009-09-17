$(function() {
  $("body").keypress(function (e) {
    if (e.which == 108) {
      var current_location = window.location.toString();
      window.location = current_location + '?next_locale'
    }
  })
});
