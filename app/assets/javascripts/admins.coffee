# Place all the behaviors and hooks related to the matching controller here.
# All this logic will automatically be available in application.js.
# You can use CoffeeScript in this file: http://coffeescript.org/

$ ->
	$('#checkAll').change ->
	  $('input:checkbox').prop 'checked', $(this).prop('checked')

	$('.btn_ajax_1').click (e) ->
		e.preventDefault()
		$.ajax
			url: '/admins/show_all_photographers'
			type: 'GET'
			data: {confirmed: 'true'}
			success: (data) ->
				$('.no-skin').html(data)

	$('.btn_ajax_2').click (e) ->
		e.preventDefault()
		$.ajax
			url: '/admins/show_all_photographers'
			type: 'GET'
			data: {confirmed: 'false'}
			success: (data) ->
				$('.no-skin').html(data)