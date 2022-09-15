# frozen_string_literal: true

FactoryBot.define do
  factory :brand, class: Brand do
    id { 2 }
    name { 'Brand' }
    manufacturer { 'Manufacturer' }
    manufacturer_email { 'manufacturer@gmail.com' }
    manufacturer_office { 'Kolkata' }
  end

  factory :invalid_brand, class: Brand do
    id { 3 }
    name { '' }
    manufacturer { 'Manufacturer' }
    manufacturer_email { 'manufacturer@gmail.com' }
    manufacturer_office { 'Kolkata' }
  end
end
