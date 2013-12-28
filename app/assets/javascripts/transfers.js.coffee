# Place all the behaviors and hooks related to the matching controller here.
# All this logic will automatically be available in application.js.
# You can use CoffeeScript in this file: http://coffeescript.org/

$ ->
  $('.datetime_field').fdatetimepicker()
  
  $(document).on 'click', '#add_line_item', (e) ->
    e.preventDefault()
    $new_element = $('#line_items .panel').last().clone()
    $new_element.find('input[type=text]').val('')
    $('#line_items').append $new_element
    return false
