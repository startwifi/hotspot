jQuery.fn.extend({
  disable: function(state) {
    return this.each(function() {
      var $this = $(this);
      $this.toggleClass('disabled', state);
    });
  }
});

$(window).load(function(){
  $('.preloader').fadeOut();
});

$('.social').click(function(){
  $('.preloader').toggle();
});

function initializeTos(enableTos) {
  if (enableTos) {
    $('body').on('click', 'a.disabled', function(event) {
      event.preventDefault();
    });
    $('.list-inline a').disable(true);
    $('#accept_tos').change(function(){
      if ($('#accept_tos').is(':checked')) {
        $('.list-inline a').disable(false);
      } else {
        $('.list-inline a').disable(true);
      };
    });
  };
}
