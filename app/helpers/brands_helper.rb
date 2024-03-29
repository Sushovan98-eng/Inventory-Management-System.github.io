# frozen_string_literal: true

# Here define the Brand helper methods for the application
module BrandsHelper
  def get_brand_name_by_id(id)
    return '<Brand N/A>' if id.nil?

    Brand.find(id).name
  end
end
