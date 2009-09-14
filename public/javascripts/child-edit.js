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
    var p = $(this).parent().parent();
    p.find('.editable').hide();
    p.find('.date-field').show();
    p.find('.date-field').datepicker('show');
    return false;
  });

  $('.date-field.existing').datepicker({
    dateFormat: 'd M yy',
    firstDay: 1,
    onClose: function() {
      var p = $(this).parent().parent();
      p.find('.editable').text($('.date-field').attr('value'));
      p.find('.editable').show();
      p.find('.date-field').hide();
    }
  });

  $('.date-field.new').datepicker({
    dateFormat: 'd M yy',
    firstDay: 1,
    onClose: function() {
      var p = $(this).parent().parent();
      p.find('.editable').show();
      p.find('.date-field').hide();
      if ($('.date-field').attr('value').length > 0)
        p.find('form').submit();
    }
  });
});
