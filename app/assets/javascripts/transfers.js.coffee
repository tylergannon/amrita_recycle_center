# Place all the behaviors and hooks related to the matching controller here.
# All this logic will automatically be available in application.js.
# You can use CoffeeScript in this file: http://coffeescript.org/

name_regexp = /transfer\[transfer_line_items_attributes\]\[(\d+)\]\[(.*)\]/
id_regexp = /transfer_transfer_line_items_attributes_(\d+)_(.*)/

inputName = ($element, index) ->
  match = name_regexp.exec $element.attr('name')
  input_name = match[2]
  'transfer[transfer_line_items_attributes][' + index.toString() + '][' + input_name + ']'

labelFor = ($element, index) ->
  match = id_regexp.exec $element.attr('for')
  input_name = match[2]
  "transfer_transfer_line_items_attributes_" + index.toString() + "_" + input_name

inputId = ($element, index) ->
  match = id_regexp.exec $element.attr('id')
  input_name = match[2]
  "transfer_transfer_line_items_attributes_" + index.toString() + "_" + input_name

addLineItem = () ->
  $line_items = $('#line_items .panel')
  $new_element = $line_items.last().clone()
  new_element_index = $line_items.size()
  
  $new_element.find('label').each (index) ->
    $this = $(this)
    $this.attr 'for', labelFor($this, new_element_index)
  
  $new_element.find('input,textarea').each (index) ->
    $(this).val('')

  $new_element.find('input,textarea,select').each (index) ->
    $this = $(this)
    $this.attr 'name', inputName($this, new_element_index)
    $this.attr 'id', inputId($this, new_element_index)

  $('#line_items').append $new_element
  $('#line_items .panel').last().find('input[type=text]').first().focus()


$ ->
  $('.datetime_field').fdatetimepicker()
  $('#line_items .panel input[type=text]').first().focus()

  $(document).on 'click', '#add_line_item', (e) ->
    e.preventDefault()
    addLineItem()
    return false
    
  $(document).on 'keydown', 'form#new_transfer input', (event) ->
    if event.which == 187
      event.preventDefault()
      addLineItem()
    # $('.coolio').append(event.which)
    
    
