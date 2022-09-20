# frozen_string_literal: true

FactoryBot.define do
  factory :category, class: Category do
    name { 'Laptop' }
    description { 'It is for Laptop' }
  end
end
