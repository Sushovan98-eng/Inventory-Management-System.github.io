# frozen_string_literal: true

FactoryBot.define do
  factory :item, class: Item do
    name { 'Item' }
    price { 100 }
    brand_id {}
    category_id {}
    total_stock { 10 }
    in_stock { 10 }
  end
end
