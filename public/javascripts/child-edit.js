$(function() {
  var form_elements = 'label, input, select, .buttons'
  $(form_elements).hide();

  $('.edit').click(function() {
    $(form_elements).show();
    $('.editable').hide();
    return false;
  });

  $('.buttons .cancel').click(function() {
    $(form_elements).hide();
    $('.editable').show();
    return false;
  });
});
