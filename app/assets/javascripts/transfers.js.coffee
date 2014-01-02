# Place all the behaviors and hooks related to the matching controller here.
# All this logic will automatically be available in application.js.
# You can use CoffeeScript in this file: http://coffeescript.org/

$ ->
  $('.datetime_field').fdatetimepicker()
  
  $(document).on 'click', '#add_line_item', (e) ->
    e.preventDefault()
    $line_items = $('#line_items .panel')
    $new_element = $line_items.last().clone()
    _.each $new_element.find('input textarea select'), ($input) ->
      
    $new_element.find('input[type=text]').val('')
    $('#line_items').append $new_element
    return false
