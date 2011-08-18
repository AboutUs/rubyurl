$(function() {
  $('a.customize').click(function(e) {
    e.preventDefault();
    $(this).hide();
    $('#customize').show();
  });
});
