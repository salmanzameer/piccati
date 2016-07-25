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
			