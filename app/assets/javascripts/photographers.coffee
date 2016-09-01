# Place all the behaviors and hooks related to the matching controller here.
# All this logic will automatically be available in application.js.
# You can use CoffeeScript in this file: http://coffeescript.org/

$ ->
  $(document).on "focus", ".datetimepicker", (e) ->
    $('.datetimepicker').datetimepicker format: 'dddd, MMMM Do YYYY HH:mm'

  $('a.calender-tab').click ->
    $('#dropdownMenu1').dropdown 'toggle'
    return

  window.onload = ->
    setTimeout (->
      $('.devise-noti').remove()
      return
    ), 3000

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
      $("#password-update").submit()

  $(document).on 'click', '#connect-client-id', (e) ->
    client_id = $('#select2-client-id').val()
    _this = $(this)
    $.ajax
      type: "POST"
      data: { client_id: client_id }
      url:  "/photographers/connect_client"
      beforeSend: ->
        $(_this).parent().append(get_ajax_loader_html())
        $(_this).attr 'disabled', true
      complete: ->
        $(_this).find("img").remove()
        $(_this).attr 'disabled', false
      success: (data) ->
        $('a.show-client-events[data-id='+client_id+']:first').click()

  $(document).on 'click', '.current-month', (e) ->
    $(".current-month").removeClass("selected-event")
    $(this).addClass("selected-event")
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

  $("#featured-image").change (e) ->
    $("#featured").val($(this).val().replace(/^.*\\/, ''))

  $(document).on 'click', '.event-submit-on-calendar', (e) ->
    e.preventDefault()
    _form = $(this).closest("form")
    _this = $(this)
    id = "#"+$(_form).attr("id")
    section_class = "."+$(this).data("section-class")
    if $(id).isValid($(id).validate())
      $.ajax
        type: "POST"
        data: _form.serialize()
        url:  _form.attr("action")
        beforeSend: ->
          $(_this).parent().append(get_ajax_loader_html())
          $(_this).attr 'disabled', true
        complete: ->
          $(_this).find("img").remove()
          $(_this).attr 'disabled', false
        success: (data) ->
          $(section_class).html(data)
          $("#update-event-popup, #add_calender_event_popup").hide()


  $(document).on 'change', '.event-category', (e) ->
    if ($('.event-category option:selected').text() == "Wedding")
      $(".bride_name, .groom_name").show()
    else
      $(".bride_name, .groom_name").hide()
    $("#add-event-form").enableClientSideValidations()

  $(".settings").click (e) ->
    e.preventDefault()
    _this = $(this)
    $(".settings").closest("tr").removeClass("Profile-heading")
    $(this).closest("tr").addClass("Profile-heading")
    $.ajax
      type: "GET"
      data: { partial_name: $(this).data("id") }
      url:  "/setting_partial"
      beforeSend: ->
        $(_this).attr 'disabled', true
      complete: ->
        $(_this).attr 'disabled', false
      success: (data) ->
        $(".show_settings").html(data)
        $('.show-package').first().click()

  $(document).on 'click', ".submit-album", (e) ->
     e.preventDefault()
     if ($("#add-photographer-album").isValid($("#add-photographer-album").validate()))
        $("#add-photographer-album").submit()

  $(document).on 'change', '#uploadBtn', (e) ->
    if $(this).prop("files")
      reader = new FileReader

    reader.onload = (e) ->
      $('.add-profile-image').attr 'src', e.target.result
      return

    reader.readAsDataURL $(this).prop("files")[0]

  $(document).on 'change', '#featured-image', (e) ->
    if $(this).prop("files")
      reader = new FileReader

    reader.onload = (e) ->
      $('.add-feature-image').attr 'src', e.target.result
      return

    reader.readAsDataURL $(this).prop("files")[0]

  $(document).on 'change', '#upload-watermark', (e) ->
    if $(this).prop("files")
      reader = new FileReader

    reader.onload = (e) ->
      $('.add-watermark-image').attr 'src', e.target.result
      return

    reader.readAsDataURL $(this).prop("files")[0]

  $(".signup_buttons_popup").click (e) ->
    e.preventDefault()
    $("#signup_buttons_popup").show()  
