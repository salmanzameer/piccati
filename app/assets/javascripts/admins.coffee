# Place all the behaviors and hooks related to the matching controller here.
# All this logic will automatically be available in application.js.
# You can use CoffeeScript in this file: http://coffeescript.org/

$ ->
	$(document).on "change", "#checkAll", ->
	  $('input:checkbox').prop 'checked', $(this).prop('checked')
	
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