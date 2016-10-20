// This is a manifest file that'll be compiled into application.js, which will include all the files
// listed below.
//
// Any JavaScript/Coffee file within this directory, lib/assets/javascripts, vendor/assets/javascripts,
// or any plugin's vendor/assets/javascripts directory can be referenced here using a relative path.
//
// It's not advisable to add code directly here, but if you do, it'll appear at the bottom of the
// compiled file. JavaScript code in this file should be added after the last require_* statement.
//
// Read Sprockets README (https://github.com/rails/sprockets#sprockets-directives) for details
// about supported directives.
//
//= require jquery
//= require jquery_ujs
//= require jquery.remotipart
//= require turbolinks
//= require cocoon
//= require_tree .

// var App = App || {};
// App.cable = ActionCable.createConsumer();

$( document ).ajaxError(function( event, jqxhr, request, settings ) {
  // json = JSON.parse(jqxhr)
  // alert(jqxhr.responseText);
  // e, xhr, status, error	
  // $( "#msg" ).append( "<li>Error requesting page " + settings.url + "</li>" );
});
$(document).ajaxComplete(function() {
  $('.button-answer').click(function() {
    $(this).parent('.answer').children('.edit_answer_form').fadeToggle();
  });
})