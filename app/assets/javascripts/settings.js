$(document).ready(function(){
  var getRouterAuthState = function() {
    if($('#ad_action option:selected').val() == 'auth') {
      $('#router_password_group').show()
    } else {
      $('#router_password_group').hide()
    }
  }

  $('#ad_action').change(function(){
    getRouterAuthState();
  });

  getRouterAuthState();
});
