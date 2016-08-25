# Place all the behaviors and hooks related to the matching controller here.
# All this logic will automatically be available in application.js.
# You can use CoffeeScript in this file: http://coffeescript.org/

$ ->

  $(document).on 'click', '.show-event', (e) ->
    e.preventDefault()
    $('td.events-list.tr-selected').removeClass('tr-selected')
    $(".show-event").css('color','#23527c')
    $(this).closest("td").addClass('tr-selected')
    $(this).css('color','white')
    id = $(this).data("id")
    photographer_id = $(this).data("photographer-id")
    client_id = $(this).data("client-id")
    $.ajax
      type: "GET"
      url:  "/clients/#{id}/event"
      success: (data) ->
        $(".clients-table").html(data)
        url = "/photographers/#{photographer_id}/clients/#{client_id}/events/#{id}"
        window.history.pushState("", "", url)