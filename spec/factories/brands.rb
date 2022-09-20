# frozen_string_literal: true

FactoryBot.define do
  factory :brand, class: Brand do
    name { 'Lenovo' }
    manufacturer { 'Lenovo Manufacturer' }
    manufacturer_email { 'Lenovo@gmail.com' }
    manufacturer_office { 'Kolkata' }
  end
end
