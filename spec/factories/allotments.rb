# frozen_string_literal: true

FactoryBot.define do
  factory :allotment, class: Allotment do
    user_id {}
    item_id {}
    allotment_quantity { 1 }
    dealloted_at { nil }
  end
end
