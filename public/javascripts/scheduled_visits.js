$(function() {
  // Register an event listener for when a visit is dropped to a new day
  // This event will be different for scheduled and recommend visits
  $('li.scheduled_visit').bind("scheduled_for", function(event, scheduled_for) {
    var visit_id = $(this).attr('data-id');

    $.ajax({
      type: 'PUT',
      url:  '/scheduled_visits/' + visit_id, 
      data: {
        'scheduled_visit[scheduled_for]': scheduled_for
      }
    });
  });

  // Allow visits to be dragged between lists
  $('.upcoming ul').sortable({
    connectWith: '.upcoming ul',
    containment: '.upcoming',
    axis:   'y',
    cancel: 'a',
    opacity: 0.8,
    receive: function(event, ui) {
      var scheduled_for = $(this).attr('data-date');

      ui.item.trigger('scheduled_for', scheduled_for);
    }
  });
});
