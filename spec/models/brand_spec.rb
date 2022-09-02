require 'rails_helper'

RSpec.describe Brand, type: :model do

  it 'name should be present and unique' do
    brand = Brand.new(name: '', manufacturer_email: 'test1@gmail.com')
    expect(brand).to_not be_valid

    brand = Brand.new(name: 'Test1', manufacturer_email: 'test2@gmail.com')
    expect(brand).to be_valid

    brand = Brand.new(name: 'Test', manufacturer_email: 'tes12@gmail.com')
    expect(brand).to_not be_valid
  end
  
  it 'manufacturer_email should be present' do
    brand = Brand.new(name: 'Test2', manufacturer_email: '')
    expect(brand).to_not be_valid

    brand = Brand.new(name: 'Test3', manufacturer_email: 'test3@gmail.com')
    expect(brand).to be_valid
  end

end
