 json.array! @allotments do |allotment|
   json.(allotment, :id, :allotment_quantity, :created_at, :dealloted_at, :item_id, :user_id)
   json.url allotment_path(allotment, format: :json)
   json.user_name allotment.user.name
   json.item_name allotment.item.name
   json.allotment_quantity allotment.allotment_quantity
   json.created_at allotment.created_at.strftime("%d-%m-%Y %H:%M")
   json.dealloted_at allotment.dealloted_at
 end
