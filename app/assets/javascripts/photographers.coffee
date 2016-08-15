# Place all the behaviors and hooks related to the matching controller here.
# All this logic will automatically be available in application.js.
# You can use CoffeeScript in this file: http://coffeescript.org/

$ ->
  
  $(document).on 'focus', '#signup-form, #add-event-form, #add-album-model, #add-client-model, .edit-package-model, #update-event-model, #add-calender-event-model, #edit-photographer, #add-photographer-album', (e) ->
    $('form').enableClientSideValidations()
 
  $(document).on 'click', '.password-edit', (e) ->
    e.preventDefault()
    if $('.cur-pass').val() == ""
      $(".cur-pass").focus()
      $(".password-error-p-tag").hide()
      $(".current-error-p-tag").hide()
      $(".current-error-p-tag").show()
    else if $('.pass').val() == ""
      $(".pass").focus()
      $(".password-error-p-tag").show()
      $(".current-error-p-tag").hide()
      $(".confirm-error-p-tag").hide()
    else if $('.pass-conf').val() == ""
      $('.pass-conf').focus()
      $(".password-error-p-tag").hide()
      $(".current-error-p-tag").hide()
      $(".confirm-error-p-tag").show()
    else
      $(".password-update").submit()

  $(document).on 'click', '#connect-client-id', (e) ->
    $.ajax
      type: "POST"
      data: { client_id: $('#select2-client-id').val() }
      url:  "/photographers/connect_client"
      success: (data) ->
        $("#connect-message").html(data)

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

  $(document).on 'change', '.event-category', (e) ->
    if ($('.event-category option:selected').text() == "Wedding")
      $(".bride_name, .groom_name").show()
    else
      $(".bride_name, .groom_name").hide()

  $(".settings").click (e) ->
    e.preventDefault()
    $(".settings").closest("tr").removeClass("Profile-heading")
    $(this).closest("tr").addClass("Profile-heading")
    $.ajax
      type: "GET"
      data: { partial_name: $(this).data("id") }
      url:  "/setting_partial"
      success: (data) ->
        $(".show_settings").html(data)
