// extend jQuery ajax with the capability of remembering the count of active ajax requests
$.activeAjaxRequestCount = 0;
 
$().ajaxSend(function() {
  $.activeAjaxRequestCount++;
  // register lazily to make sure it's the last one and get executed after all other handlers
  if (!$._ajaxErrorHandlerAdded) {
    $().ajaxError(function() {
      $.activeAjaxRequestCount--;
    });
    $._ajaxErrorHandlerAdded = true;
  }
})
.ajaxSuccess(function() {
  $.activeAjaxRequestCount--;
});
