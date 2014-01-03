module WorksheetsHelper
  def pickup_link_path(category_id, container_id)
    new_transfer_path \
      from: {category_id: category_id, location_id: 'waste_station'}, 
      to: {container_id: container_id, location_id: 'pre_sort', category_id: category_id}, 
      worksheet: 'delivery'
  end
end
