# Place all the behaviors and hooks related to the matching controller here.
# All this logic will automatically be available in application.js.
# You can use CoffeeScript in this file: http://coffeescript.org/

$ ->

  $(document).on 'click', '.show-package', (e) ->
    e.preventDefault()
    $('.tr-selected').removeClass('tr-selected')
    $(this).closest("tr").addClass('tr-selected')
    id = $(this).data("id")
    $.ajax
      type: "GET"
      url: "/packages/#{id}"
      success: (data) ->
        $(".pkg-settings").html(data)

  $(document).on 'click', '.update-package-setting, .add-package-setting', (e) ->
    e.preventDefault()
    _form = $(this).closest("form")
    id = "#"+$(_form).attr("id")
    package_id = $(this).data("package")
    if ($(id).isValid($(id).validate()))
      $.ajax
        type: "POST"
        data: _form.serialize()
        url:  _form.attr("action")
        success: (data) ->
          $(".package-list").html(data)
          progress = $('.add-package-setting').data('progress')+15
          $('.c100').addClass("p" + progress)
          $('.progress-text').text(progress+"%")
          $("#add_pkg_popup, #edit_pkg_popup").hide()
          if id == "#edit-photographer-package-setting"
            $('.show-package[data-id='+"#{package_id}"+']:first').click()
          else
            $('.show-package').last().click()