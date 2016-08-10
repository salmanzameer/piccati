# Place all the behaviors and hooks related to the matching controller here.
# All this logic will automatically be available in application.js.
# You can use CoffeeScript in this file: http://coffeescript.org/

$ ->
  
  $(document).on 'click', '#signup-form,#add-event-form,#add-client-model, #add-album-model, .edit-package-model, #update-event-model, #add-calender-event-model, #edit-photographer, #add-photographer-album', (e) ->
    $('form').enableClientSideValidations()

  $(document).on 'click', '.day', (e) ->
    e.preventDefault()
    $.ajax
      type: "GET"
      url:  "/scheduled_events/"+$(this).text().match(/\S+/g)[0]
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
