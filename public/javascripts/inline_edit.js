$(function() {
  var inlineEditLink = function(element, toShow, toHide) {
    $(element).click(function() {
      var form = $(this).parents('form');
      form.find(toHide).hide();
      form.find(toShow).show();
      return false;
    });
  }
  inlineEditLink('#cancel-link', '.show', '.edit');
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
