$(function() {
  // Register an event listener for when a visit is dropped to a new day
  // This event will be different for scheduled and recommend visits
  var scheduledVisitEvent = function(event, scheduledFor) {
    var target = $(this);
    var visit_id = $(this).attr('data-id');

    $.ajax({
      type: 'PUT',
      url:  '/scheduled_visits/' + visit_id,
      data: {
        'scheduled_visit[scheduled_for]': scheduledFor
      },
      error: function() {
        window.location.reload();
      },
      success: function() {
        target.removeClass('pending');
      }
    });
  }

  $('li.scheduled_visit'  ).bind("scheduledFor", scheduledVisitEvent);

  $('li.recommended_visit').bind("scheduledFor", function(event, scheduledFor) {
    var target = $(this);
    var child_id = target.attr('data-id');

    $.ajax({
      type: 'POST',
      url:  '/scheduled_visits',
      dataType: 'json',
      data: {
        'child_id': child_id,
        'scheduled_visit[scheduled_for]': scheduledFor
      },
      error: function() {
        window.location.reload();
      },
      success: function(responseData) {
        with(target) {
          addClass('scheduled_visit');
          removeClass('recommended_visit');
          removeClass('pending');
          attr('data-id', responseData.id);
          unbind('scheduledFor');
          bind('scheduledFor', scheduledVisitEvent);
        }
      }
    });
  });

  // Allow visits to be dragged between lists
  $('.upcoming ul').sortable({
    connectWith: '.upcoming ul',
    containment: '.upcoming',
    axis:   'y',
    cancel: 'a, .pending',
    opacity: 0.8,
    receive: function(event, ui) {
      ui.item.addClass('pending');
      ui.item.trigger('scheduledFor', $(this).attr('data-date'));
    }
  });

  $('.overdue ul').sortable({
    axis: 'y',
    connectWith: '.upcoming ul',
    cancel: 'a',
    opacity: 0.8
  });

  $('.recommended ul').sortable({
    connectWith: '.upcoming ul',
    cancel: 'a',
    opacity: 0.8
  });
});
