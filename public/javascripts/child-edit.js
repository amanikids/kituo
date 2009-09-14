$(function() {
  var form_elements = $('#child-form label, #child-form input, #child-form select, .buttons');
  $(form_elements).hide();

  $('.edit').click(function() {
    $(form_elements).show();
    $('#child-form .editable, .edit .editable').hide();
    return false;
  });

  $('.buttons .cancel').click(function() {
    $(form_elements).hide();
    $('#child-form .editable, .edit .editable').show();
    return false;
  });

  $('.buttons .save').click(function() {
    $('#child-form').submit();
    return false;
  });




  $('.change').click(function() {
    $('.child-visits .editable').hide();
    $('.date-field').show();
    $('.date-field').datepicker('show');
    return false;
  });

  picker = $('.date-field').datepicker({
    dateFormat: 'd M yy',
    firstDay: 1,
    onClose: function() {
      $('.child-visits .editable').text($('.date-field').attr('value'));
      $('.child-visits .editable').show();
      $('.date-field').hide();
    }
  });
});
