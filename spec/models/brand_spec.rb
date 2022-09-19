# frozen_string_literal: true

require 'rails_helper'

RSpec.describe Brand, type: :model do
  it 'name should be present' do
    brand = Brand.new(id: 1, name: '', manufacturer_email: 'test1@gmail.com',created_at: Time.now, updated_at: Time.now)
    expect(brand).to_not be_valid

    brand = Brand.new(id: 1, name: 'Test3', manufacturer_email: 'test2@gmail.com')
    expect(brand).to be_valid
  end

  it 'manufacturer_email should be present' do
    brand = Brand.new(name: 'Test2', manufacturer_email: '')
    expect(brand).to_not be_valid

    brand = Brand.new(name: 'Test3', manufacturer_email: 'test3@gmail.com')
    expect(brand).to be_valid
  end
end
