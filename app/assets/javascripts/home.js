// Place all the behaviors and hooks related to the matching controller here.
// All this logic will automatically be available in application.js.
$(function() {
  $('#borrower').submit(function(e) {
    e.preventDefault();
    e.stopPropagation();
    var borrower_number = $('#borrower_number').val();
    $('#calendar_url').val('https://' + location.host + '/loans.ics?borrower=' + borrower_number);
    $('#borrower-calendar').show();
  });
});
