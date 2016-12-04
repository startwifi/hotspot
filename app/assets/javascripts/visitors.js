jQuery.fn.extend({
  disable: function(state) {
    return this.each(function() {
      var $this = $(this);
      $this.toggleClass('disabled', state);
    });
  }
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
};

var preloaderFadeOut = function(){
  $('.preloader').fadeOut();
}

$(document).ready(function(){
  preloaderFadeOut();

  $('.social').click(function(){
    $('.preloader').show();
  });

  $('#continue_btn').disable(true);

  var timer = 15;
  var interval = setInterval(function() {
    timer--;
    $('span#timer').text(timer);
    if (timer == 0) {
      $('span#timer').remove();
      $('#continue_btn').disable(false);
    }
  }, 1000);

  return setTimer = function(){
    setTimeout()
  };
});

$(document).on('page:load', preloaderFadeOut);
