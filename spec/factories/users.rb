# frozen_string_literal: true

FactoryBot.define do
  factory :admin, class: User do
    id { 1 }
    name { 'admin' }
    email { 'admin12@gmail.com' }
    password { 'admin123' }
    password_confirmation { 'admin123' }
    admin { true }
    mobile_no { '1234567890' }
  end

  factory :user, class: User do
    id { 2 }
    name { 'User' }
    email { 'user1@gmail.com' }
    password { 'user123' }
    password_confirmation { 'user123' }
    admin { false }
    mobile_no { '1234567890' }
  end
end
