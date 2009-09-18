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
  var commonSortableOptions = {
    connectWith: '.upcoming ul',
    cancel:      'a, .pending',
    opacity:     0.8
  };

  $('.upcoming ul').sortable($.extend({
    axis:        'y',
    containment: '.upcoming',
    receive: function(event, ui) {
      ui.item.addClass('pending');
      ui.item.trigger('scheduledFor', $(this).attr('data-date'));
    }
  }, commonSortableOptions));

  $('.overdue ul').sortable($.extend({
      axis: 'y',
  }, commonSortableOptions));

  $('.recommended ul').sortable(commonSortableOptions);
});
