module WorksheetsHelper
  def pickup_link_path(category_id, container_id)
    to_presort_path category_id, container_id, 'waste_station'
  end
  
  def from_compost_link_path(category_id, container_id)
    to_presort_path category_id, container_id, 'compost'
  end
  
  def to_presort_path(category_id, container_id, from_location_id)
    new_transfer_path \
    from: {category_id: category_id, location_id: from_location_id, from_category_id: 'waste_station'},
    to: {container_id: container_id, category_id: category_id, location_id: 'pre_sort'}
  end
  
  def presort_link_path(category_id, container_id, location_id)
    new_transfer_path \
      from: {category_id: category_id, location_id: 'pre_sort'}, 
      to: {container_id: container_id, location_id: location_id, category_id: category_id}, 
      worksheet: 'delivery'
  end
end
