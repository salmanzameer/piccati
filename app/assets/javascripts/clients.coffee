# Place all the behaviors and hooks related to the matching controller here.
# All this logic will automatically be available in application.js.
# You can use CoffeeScript in this file: http://coffeescript.org/

$ ->
	$(document).on 'click', '.event-submit-on-calendar, .connect-with-client, .update-event, .submit-event', (e) ->
		$('.connect-client-form, #add-event-form, #update-event-model, #add-calender-event-model').find('input').filter(->
	  	if $(this).val() == ''
	    	$(this).focus()
	    	$(this).focusout()
	    	return
		).first().focus()
	
	$(document).on 'click', '.event-submit-on-calendar, .update-package-setting, .add-package-setting, .event-submit-on-calendar, .submit-event', (e) ->
	 	$('#add-calender-event-model, #create-photographer-package-setting, #edit-photographer-package-setting, #update-event-model, #add-event-form').find('input, select').filter(->
	   	if $(this).val() == ''
	     	$(this).focus()
	     	return
	 	).first().focus()

	$(document).on 'click', '.submit-event', (e) ->
		e.preventDefault()
		_form = $(this).closest("form")
		_this = $(this)
		id = "#"+$(_form).attr("id")
		if ($(id).isValid($(id).validate()))
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
					$(".events-section").html(data)
					$("#abc2").hide()
					$('.show-event').last().click()

	$(document).on 'click', '.edit-package', (e) ->
		e.preventDefault()
		console.log("submit");
		_form = $(this).closest("form")
		_this = $(this)
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
				$(".package-details").html(data)
				$("#edit_client_popup").hide()

	$(document).on 'click', '.client-id', (e) ->
		e.preventDefault()
		client_id = $(this).data("client")
		$.ajax
			type: "GET"
			url: "/clients/#{client_id}/edit_package"
			success: (data) ->
				$(".edit-package-form").html(data)
				$("#edit_client_popup").show()
				$('#package-update-client').enableClientSideValidations()

	$(document).on 'click', '.show-client-events', (e) ->
		e.preventDefault()
		$('.tr-selected').removeClass('tr-selected')
		$(this).closest("tr").addClass('tr-selected')
		id = $(this).data("id")
		photographer_id = $(this).data("photographer-id")
		$.ajax
			type: "GET"
			url: "/clients/#{id}/client_events"
			success: (data) ->
				$(".events-section").html(data)
				$('.show-event').first().click()
				url = "/photographers/#{photographer_id}/clients/#{id}"
				window.history.pushState("", "", url)

	$(document).on 'click', '.close', (e) ->
		$(".clients-table").show()
		$("##{$(this).data("id")}").hide()
			
	submitIcon = $('.searchbox-icon')
	inputBox = $('.searchbox-input')
	searchBox = $('.searchbox')
	isOpen = false

	buttonUp = ->
	  inputVal = $('.searchbox-input').val()
	  inputVal = $.trim(inputVal).length
	  if inputVal != 0
	    $('.searchbox-icon').css 'display', 'none'
	  else
	    $('.searchbox-input').val ''
	    $('.searchbox-icon').css 'display', 'block'
	  return

		submitIcon.click ->
		  if isOpen == false
		    searchBox.addClass 'searchbox-open'
		    inputBox.focus()
		    isOpen = true
		  else
		    searchBox.removeClass 'searchbox-open'
		    inputBox.focusout()
		    isOpen = false
		  return
		submitIcon.mouseup ->
		  false
		searchBox.mouseup ->
		  false
		$(document).mouseup ->
		  if isOpen == true
		    $('.searchbox-icon').css 'display', 'block'
		    submitIcon.click()
		  return
	$(document).on 'keyup', '.search_client_email', (e) ->
		$.ajax
			type: "GET"
			url: "/search_clients"
			data: { email:  $(this).val() }
			success: (data) ->
				$(".searched_email").html(data)
				$(".searched_email").show()
				$(".error-p-tag").hide()

	$(document).on 'focusout', '.search_client_email', (e) ->
		e.preventDefault()
		$(".searched_email").hide()
		$.ajax
			type: "GET"
			url:  "/clients/search_client_fields"
			data: { email: $(".search_client_email").val() }

	$(document).on 'click', '.update-event', (e) ->
		e.preventDefault()
		$.ajax
			type: "GET"
			url:  "/clients/"+$(this).data("client-id")+"/events/"+$(this).data("id")+"/edit"
			success: (data) ->
				$(".edit-event-section").html(data)
				$("#update-event-popup").show()
				$('#update-event-model').enableClientSideValidations()

	$(document).on 'click', '.client_management_popup', (e) ->
		id = "#"+$(this).data("id")
		popup = "#"+$(this).data("popup")
		e.preventDefault()
		$.ajax
			type: "GET"
			url:  "/get_forms"
			data: { form_name:  $(this).data("id"), package_id: $(this).data("package-id"), client_id: $(this).data("client-id"), calendar_type: $(this).data("calendar-type") }
			success: (data) ->
				$(id).html(data)
				$(popup).show()
				$("#event_start_time").val($(".selected-date-div").text())
				$("#"+$(popup).find('form').attr("id")).enableClientSideValidations()

	$(".invite-client-again").click (e) ->
		e.preventDefault()
		$.ajax
			type: "POST"
			url:  "/invite_client"
			data: { id: $(this).data("id") }