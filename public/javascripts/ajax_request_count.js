// extend jQuery ajax with the capability of remembering the count of active ajax requests
$.activeAjaxRequestCount = 0;

var timeout = null;
function toggleLoadIndicator() {
  $('#ajax-loading').stop();
  if ($.activeAjaxRequestCount > 0) {
    timeout = setTimeout(function() {
      $('#ajax-loading').fadeIn();
    }, 200);
  } else {
    clearTimeout(timeout);
    $('#ajax-loading').fadeOut();
  }
}

$().ajaxSend(function() {

  $.activeAjaxRequestCount++;
  toggleLoadIndicator();
  // register lazily to make sure it's the last one and get executed after all other handlers
  if (!$._ajaxErrorHandlerAdded) {
    $().ajaxError(function() {
      $.activeAjaxRequestCount--;
      toggleLoadIndicator();
    });
    $._ajaxErrorHandlerAdded = true;
  }
})
$().ajaxSuccess(function() {
  $.activeAjaxRequestCount--;
  toggleLoadIndicator();
});
