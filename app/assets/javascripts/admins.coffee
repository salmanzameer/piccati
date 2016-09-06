# Place all the behaviors and hooks related to the matching controller here.
# All this logic will automatically be available in application.js.
# You can use CoffeeScript in this file: http://coffeescript.org/

$ ->
	$('#checkAll').change ->
	  $('input:checkbox').prop 'checked', $(this).prop('checked')

	$('.Executive, .Premium, .Standard').click (e) ->
		e.preventDefault()
		$.ajax
			url: '/admins/show_all_photographers'
			type: 'GET'
			data: {plan_type: $(this).text()}
			success: (data) ->
				$('body').html(data)

	$('.free').click (e) ->
		e.preventDefault()
		$.ajax
			url: '/admins/show_all_clients'
			type: 'GET'
			data: {client_type: 'false'}
			success: (data) ->
				$('body').html(data)

	$('.connected').click (e) ->
		e.preventDefault()
		$.ajax
			url: '/admins/show_all_clients'
			type: 'GET'
			data: {client_type: 'true'}
			success: (data) ->
				$('body').html(data)
