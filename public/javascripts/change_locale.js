$(function() {
  $("body").keypress(function (e) {
    if (e.which == 108 && e.metaKey == false) {
      var current_location = window.location.toString();
      window.location = current_location + '?next_locale'
    }
  })
});
