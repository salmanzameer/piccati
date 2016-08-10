# Place all the behaviors and hooks related to the matching controller here.
# All this logic will automatically be available in application.js.
# You can use CoffeeScript in this file: http://coffeescript.org/

$ ->
  $(document).on 'click', '#signup-form, #add-event-form, #add-album-model, .edit-package-model, #update-event-model, #add-calender-event-model, #edit-photographer, #add-photographer-album', (e) ->
    $('form').enableClientSideValidations()

  $(document).on 'click', '.current-month', (e) ->
    e.preventDefault()
    $.ajax
      type: "GET"
      url:  "/scheduled_events/"+$(this).text().match(/\S+/g)[0]+" "+$(".calendar-title").text()
      beforeSend: ->
        $("#loading-image").show()
      success: (data) ->
        $(".scheduled-events").html(data)
        $("#loading-image").hide()

  $(document).on 'click', '.week-sel', (e) ->
    $('.button_class').text('Weekly')

  $(document).on 'click', '.month-sel', (e) ->
    $('.button_class').text('Monthly')

  $("#uploadBtn").change (e) ->
    $("#uploadFile").val($(this).val().replace(/^.*\\/, ''))

  $("#upload-watermark").change (e) ->
    $("#watermark-url").val($(this).val().replace(/^.*\\/, ''))

  $(document).on 'click', '.event-submit-on-calendar', (e) ->
    e.preventDefault()
    _form = $(this).closest("form")
    $.ajax
      type: "POST"
      data: _form.serialize()
      url:  _form.attr("action")
      success: (data) ->
        $(".calender_and_info").html(data)
        $("#abc2").hide()