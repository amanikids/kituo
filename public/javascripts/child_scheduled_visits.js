$(function() {
  var scheduledVisitForm = function(element) {
    return $(element).parents('.scheduled_visit').find('form');
  }

  $('#new-scheduled-visit, .edit-scheduled-visit').click(function() {
    with(scheduledVisitForm(this)) {
      find('.show').hide();
      find('.date-field').show();
      find('.date-field').datepicker('show');
    }
    return false;
  });

  $('.date-field').datepicker({
    dateFormat: 'd M yy',
    firstDay: 1,
    onClose: function() {
      with(scheduledVisitForm(this)) {
        find('.date-field').hide();
        if (find('.date-field').val().length > 0) {
          submit();
        }
      }
    }
  });
});
