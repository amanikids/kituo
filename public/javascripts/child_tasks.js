$(function() {
  $('.child-tasks input, .child-tasks select').change(function() {
    $(this).parents('form').submit();
  })
});