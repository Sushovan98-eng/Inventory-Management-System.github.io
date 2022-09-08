# frozen_string_literal: true

# Here define the Item helper methods for the application
module ItemsHelper
  include BrandsHelper
  def item_display_name(item)
    return '<Item deleted>' if item.nil?

    "Name:#{item.name} (Brand:#{get_brand_name_by_id item.brand_id})"
  end

  def get_item_by_id(id)
    return nil if id.nil?

    Item.find(id)
  end
end
