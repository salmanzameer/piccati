# Place all the behaviors and hooks related to the matching controller here.
# All this logic will automatically be available in application.js.
# You can use CoffeeScript in this file: http://coffeescript.org/

$ ->

	$(document).on 'click', '.submit-event', (e) ->
		e.preventDefault()
		_form = $(this).closest("form")
		$.ajax
			type: "POST"
			data: _form.serialize()
			url:  _form.attr("action")
			success: (data) ->
				$(".events-section").html(data)
				$("#abc2").hide()
				$('.show-event').last().click()

	$(document).on 'click', '.edit-package', (e) ->
		e.preventDefault()
		console.log("submit");
		_form = $(this).closest("form")
		$.ajax
			type: "POST"
			data: _form.serialize()
			url:  _form.attr("action")
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

	$(document).on 'click', '.show-client-events', (e) ->
		e.preventDefault()
		$('.tr-selected').removeClass('tr-selected')
		$(this).closest("tr").addClass('tr-selected')
		$(this).css('color','white')
		id = $(this).data("id")
		$.ajax
			type: "GET"
			url: "/clients/#{id}/client_events"
			success: (data) ->
				$(".events-section").html(data)
				$('.show-event').first().click()
				$('.events-list.abc').find("a").click()

	$(document).on 'click', '.popup', (e) ->
		$("##{$(this).data("id")}").show()

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

	$(".search_client_email").keyup (e) ->
		if ($(this).val().length >= 3)
			$.ajax
				type: "GET"
				url: "/search_clients"
				data: { email:  $(this).val() }
				success: (data) ->
					$(".searched_email").html(data)
					$(".searched_email").show()
	
	$(document).on 'click', '.select-searched-email', (e) ->
		e.preventDefault()
		$(".search_client_email").val($(this).text())	
		$(".searched_email").hide()

	$('.show-client-events').first().click()
	$('.clients-list.abc').find("a").click()
	
	$(document).on 'click', '.update-event', (e) ->
		e.preventDefault()
		$.ajax
			type: "GET"
			url:  "/clients/"+$(this).data("client-id")+"/events/"+$(this).data("id")+"/edit"
			success: (data) ->
				$(".edit-event-section").html(data)
				$("#update-event-popup").show()