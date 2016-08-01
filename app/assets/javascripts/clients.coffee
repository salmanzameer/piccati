# Place all the behaviors and hooks related to the matching controller here.
# All this logic will automatically be available in application.js.
# You can use CoffeeScript in this file: http://coffeescript.org/

$ ->
	$(document).on 'click', '.submit-event', (e) ->
		e.preventDefault()
		console.log("submit");
		_form = $(this).closest("form")
		$.ajax
			type: "POST"
			data: _form.serialize()
			url:  _form.attr("action")
			success: (data) ->
				$(".events-section").html(data)


	$(document).on 'click', '.show-client-events', (e) ->
		e.preventDefault()
		$('.clients-tr').removeClass('tr-selected')
		$(".show-client-events").css('color','#23527c')
		$(this).closest("tr").addClass('tr-selected')
		$(this).css('color','white')
		id = $(this).data("id")
		$.ajax
			type: "GET"
			url: "/clients/#{id}/client_events"
			success: (data) ->
				$(".events-section").html(data)

	$(document).on 'click', '.popup', (e) ->
		$("##{$(this).data("id")}").show()
		$(".clients-table").hide()

	$(document).on 'click', '.close', (e) ->
		$(".clients-table").show()
		$("##{$(this).data("id")}").hide()
			
	$('.show-client-events').first().click().closest("tr").addClass("tr-selected")

	
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