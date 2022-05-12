module ItemsHelper
    include BrandsHelper
    def item_display_name(item)
      return "<Item deleted>" if item.nil?
      "Brand:#{get_brand_name_by_id item.brand_id} Item:#{item.name} Quantity:(#{item.quantity})"
    end
  
    def get_item_by_id(id)
      return nil if id.nil?
      Item.find(id)
    end
  end