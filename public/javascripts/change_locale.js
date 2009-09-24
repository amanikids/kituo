$(function() {
  $("body").keypress(function (e) {
    if (e.which == 92 && e.metaKey == true) {
      window.location = $("link.locale").attr("href");
    }
  })
});
