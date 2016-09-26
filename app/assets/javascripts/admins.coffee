# Place all the behaviors and hooks related to the matching controller here.
# All this logic will automatically be available in application.js.
# You can use CoffeeScript in this file: http://coffeescript.org/

$ ->
	$('#checkAll').change ->
	  $('input:checkbox').prop 'checked', $(this).prop('checked')

	$('#types').change (e) ->
		e.preventDefault()
		$.ajax
			url: '/admins/photographers'
			type: 'GET'
			data: {plan_type: $('#types :selected ').text() }
			success: (data) ->
				$('.table-container').html($(data).find('.photographers_details'))
	
	$(document).on "change", "#client_type, #plan_type", (e) -> 
		e.preventDefault()
		$.ajax
			url: $(this).closest('form').attr('action')
			type: 'GET'
			data: { type: $("#"+$(this).attr('id')+" :selected").val() }
			
	$('.unselected').click ->
  	$('.unselected').removeClass 'selected'
  	$(this).addClass 'selected'

  $(document).on "click", ".photographer_image_popup", (e) ->
    e.preventDefault()
    $("#photographer_image_popup").show()