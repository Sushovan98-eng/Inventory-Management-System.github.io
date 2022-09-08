# frozen_string_literal: true

# Here define the Category helper methods for the application
module CategoriesHelper
  def get_category_name_by_id(id)
    return '<Brand N/A>' if id.nil?

    Category.find(id).name
  end
end
