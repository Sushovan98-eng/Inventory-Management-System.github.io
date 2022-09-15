# frozen_string_literal: true

FactoryBot.define do
  factory :category, class: Category do
    id { 2 }
    name { 'Category' }
    description { 'Description' }
  end

  factory :invalid_category, class: Category do
    id { 3 }
    name { '' }
    description { 'Description' }
  end
end
