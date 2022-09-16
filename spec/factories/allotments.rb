# frozen_string_literal: true

FactoryBot.define do
  factory :allotment, class: Allotment do
    id { 1 }
    user_id { 2 }
    item_id { 2 }
    allotment_quantity { 1 }
  end

  factory :dealloted_allotment, class: Allotment do
    id { 2 }
    user_id { 2 }
    item_id { 2 }
    allotment_quantity { 1 }
    dealloted_at { Time.now }
  end
end
