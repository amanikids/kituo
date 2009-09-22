$(function() {
  var inlineEditLink = function(element, toShow, toHide, callback) {
    $(element).click(function() {
      var form = $(this).parents('form');
      form.find(toHide).hide();
      form.find(toShow).show();
      if (callback) {
        callback(form);
      }
      return false;
    });
  }
  inlineEditLink('#cancel-link', '.show', '.edit', function(form) { form.reset(); });
  inlineEditLink('#edit-link',   '.edit', '.show');

  // TODO: This is overridden by lib/form_builder.rb, so doesn't work.
  // Make it work
  /*
  $('#edit-child').submit(function() {
    if ($('#child_name').val() == '') {
      return false;
    }
  });
  */
});
