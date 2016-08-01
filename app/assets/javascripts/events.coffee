# Place all the behaviors and hooks related to the matching controller here.
# All this logic will automatically be available in application.js.
# You can use CoffeeScript in this file: http://coffeescript.org/

$ ->
  $(document).on 'click', '.show-event', (e) ->
    e.preventDefault()
    id = $(this).data("id")
    $.ajax
      type: "GET"
      url:  "/clients/#{id}/event"
      success: (data) ->
        $(".clients-table").html(data)