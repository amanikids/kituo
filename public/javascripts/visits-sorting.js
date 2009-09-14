$(function() {
  extractId = function(element) {
    return element.id.split('_')[1];
  }

  $('.visits .scheduled ul').sortable({
    connectWith: '.visits .scheduled ul',
    containment: '.scheduled',
    axis: 'y',
    revert: true,
    cancel: 'a',
    opacity: 0.8,
    start: function() {
      sorting = true;
    },
    stop: function(event, ui) {
      // extract ID, AJAX post to the server to reschedule
    }
  }).find('li').css({cursor: 'move'});

  $('.recommended ul').sortable({
    connectWith: '.visits .scheduled ul',
    opacity: 0.8,
    cancel: 'a',
    revert: true
  }).find('li').css({cursor: 'move'});

  $('.completed a').click(function() {
    $('#completed-dialog').dialog('open');
    return false
  });
  $('#completed-dialog').dialog({
    width: 400,
    height: 280,
    maxHeight: 280,
    minHeight: 280,
    autoOpen: false,
    title: 'Completed Visit'
  });
});
