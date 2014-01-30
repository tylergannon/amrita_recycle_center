# Place all the behaviors and hooks related to the matching controller here.
# All this logic will automatically be available in application.js.
# You can use CoffeeScript in this file: http://coffeescript.org/

name_regexp = /transfer\[transfer_line_items_attributes\]\[(\d+)\]\[(.*)\]/
id_regexp = /transfer_transfer_line_items_attributes_(\d+)_(.*)/

reinterpretPageTitle = ->
  location = $('#transfer_debit_attributes_location_id [selected]').html()
  category = $('#transfer_debit_attributes_category_id [selected]').html()
  # alert("Materials Transfer from " + location + " / " + category)
  $('.page_title').html("Materials Transfer from " + location + " / " + category)

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

categoryChanged = (event) ->
  $this = $(this)
  default_container_id = $this.find('option:selected').attr('data-default-container')
  $container_select = $this.parents('.line_item').find('select.container')
  $container_select.val(default_container_id)
  $container_select.trigger('chosen:updated')

addLineItem = () ->
  $line_items = $('#line_items .line_item')
  $last_line_item = $line_items.last()
  $new_element = window.transferred_item.clone()
  new_element_index = $line_items.size()
  
  $new_element.find('label').each (index) ->
    $this = $(this)
    $this.attr 'for', labelFor($this, new_element_index)
  
  _.each ['category', 'container', 'location'], (name) ->
    $new_element.find('select.' + name).val $last_line_item.find('select.' + name).val()

  $new_element.find('input[name],textarea[name],select[name]').each (index) ->
    $this = $(this)
    $this.attr 'name', inputName($this, new_element_index)
    $this.attr 'id', inputId($this, new_element_index)

  $('#line_items').append $new_element
  $('#line_items .line_item').last().find('select').chosen()
  $('#line_items .line_item').last().find('input[type=text]').first().focus()


$ ->
  window.transferred_item = $('#line_items .line_item').first().clone()
  $('#line_items .line_item select').chosen()
  $('.datetime_field').fdatetimepicker()
  $('#line_items .line_item input[type=text]').first().focus()
  
  $(document).on 'change', 'select.category', categoryChanged

  $(document).on 'change', '.set_title', reinterpretPageTitle
  $(document).on 'click', '#add_line_item', (e) ->
    e.preventDefault()
    addLineItem()
    return false
    
  $(document).on 'click', '.show_notes', (event) ->
    event.preventDefault()
    $(this).parents('.line_item').find('.row.item-notes').show()
  $(document).on 'click', '.remove_item', (event) ->
    event.preventDefault()
    $(this).parents('.line_item').remove()

  $(document).on 'keydown', 'form#new_transfer input', (event) ->
    if event.which == 187
      event.preventDefault()
      addLineItem()
    # $('.coolio').append(event.which)
    
    
