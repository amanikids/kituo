$(function() {
  $('#edit-link').click(function() {
    $('.show').hide();
    $('.edit').show();
    return false;
  })

  $('#cancel-link').click(function() {
    $('.edit').hide();
    $('.show').show();
    return false;
  })

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
