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


  $(document).on 'click', '.week-sel', (e) ->
    $('.button_class').text('Weekly')

  $(document).on 'click', '.month-sel', (e) ->
    $('.button_class').text('Monthly')

  $("#uploadBtn, #upload-watermark").change (e) ->
    $("#uploadFile").val($(this).val())

  $("#upload-watermark").change (e) ->
    $("#watermark-url").val($(this).val())
