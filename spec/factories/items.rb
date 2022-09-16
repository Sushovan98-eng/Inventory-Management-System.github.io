# frozen_string_literal: true

FactoryBot.define do
  factory :item, class: Item do
    id { 2 }
    name { 'Item' }
    price { 100 }
    brand_id { 1 }
    category_id { 1 }
    total_stock { 10 }
    in_stock { 10 }
  end

  factory :invalid_item, class: Item do
    id { 3 }
    name { '' }
    description { 'Description' }
    price { 100 }
    brand_id
    category_id
    total_stock { 10 }
    in_stock { 10 }
  end
end
