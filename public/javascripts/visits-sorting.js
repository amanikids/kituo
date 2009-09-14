$(function() {
  extractId = function(element) {
    return element.id.split('_')[1];
  }

  $('.visits .scheduled ul').sortable({
    connectWith: '.visits .scheduled ul',
    containment: '.scheduled',
    axis: 'y',
    stop: function(event, ui) {
      var dialog = $('#day-selector');
      dialog.css({
        'left': event.clientX - dialog.width() / 2,
        'top':  event.clientY - dialog.height() / 2
      }).data('visit-id', extractId(ui.item[0])).show();
    }
  });

  $('#day-selector a').click(function() {
    var id = $('#day-selector').data('visit-id');
    console.log(this.className, id);
    $('#child_' + id + ' .day').text($(this).text());
    $('#day-selector').hide();
    return false;
  });
});
