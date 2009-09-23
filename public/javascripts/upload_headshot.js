$(function() {
  $('.headshot-required input').change(function() {
    $(this).parents('form').submit();
  })
});