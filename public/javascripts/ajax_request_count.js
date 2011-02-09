$(function() {
  $('#ajax-loading').ajaxStart(function() {
    $(this).fadeIn();
  });

  $('#ajax-loading').ajaxStop(function() {
    $(this).fadeOut();
  });
});
