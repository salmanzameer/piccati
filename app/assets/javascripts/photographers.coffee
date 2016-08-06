# Place all the behaviors and hooks related to the matching controller here.
# All this logic will automatically be available in application.js.
# You can use CoffeeScript in this file: http://coffeescript.org/

$ ->
  $(document).on 'click', '.day', (e) ->
    e.preventDefault()
    $.ajax
      type: "GET"
      url:  "/scheduled_events/"+$(this).text()
      success: (data) ->
        $(".scheduled-events").html(data)