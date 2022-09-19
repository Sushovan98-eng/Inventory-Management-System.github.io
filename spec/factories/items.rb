# frozen_string_literal: true

FactoryBot.define do
  factory :item, class: Item do
    id { 2 }
    name { 'Item' }
    price { 100 }
    brand_id { 2 }
    category_id { 2 }
    total_stock { 10 }
    in_stock { 10 }
  end

  factory :item3, class: Item do
    id { 3 }
    name { 'Item3' }
    price { 100 }
    brand_id { 4 }
    category_id { 2 }
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
