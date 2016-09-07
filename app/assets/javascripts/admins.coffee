# Place all the behaviors and hooks related to the matching controller here.
# All this logic will automatically be available in application.js.
# You can use CoffeeScript in this file: http://coffeescript.org/

$ ->
	$('#checkAll').change ->
	  $('input:checkbox').prop 'checked', $(this).prop('checked')

	$('#types').change (e) ->
		e.preventDefault()
		$.ajax
			url: '/admins/show_all_photographers'
			type: 'GET'
			data: {plan_type: $('#types :selected ').text() }
			success: (data) ->
				$('.table-container').html($(data).find('.photographers_details'))

	$('#client_type').change (e) ->
		e.preventDefault()
		$.ajax
			url: '/admins/show_all_clients'
			type: 'GET'
			data: {client_type: $('#client_type :selected ').text() }
			success: (data) ->
				$('.table-container').html($(data).find('.clients_details'))
				
