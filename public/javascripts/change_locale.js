$(function() {
  $("body").keypress(function (e) {
    if (e.which == 108 && e.metaKey == false) {
      window.location = $("link.locale").attr("href");
    }
  })
});
