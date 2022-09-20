# frozen_string_literal: true

require 'rails_helper'

RSpec.describe Brand, type: :model do
  it 'name should be present' do
    brand = Brand.new(name: '', manufacturer_email: 'manufacturer1@gmail.com', manufacturer_office: 'Kolkata')
    expect(brand).to_not be_valid

    brand = Brand.new(name: 'HP', manufacturer_email: 'manufacturer2@gmail.com')
    expect(brand).to be_valid
  end

  it 'manufacturer_email should be present' do
    brand = Brand.new(name: 'Dell', manufacturer_email: '')
    expect(brand).to_not be_valid

    brand = Brand.new(name: 'Dell', manufacturer_email: 'manufacturer3@gmail.com')
    expect(brand).to be_valid
  end
end
