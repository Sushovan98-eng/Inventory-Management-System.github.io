require 'rails_helper'

RSpec.describe Item, type: :model do

  # it { should have_many(:issues) }
  # it { should have_many(:allotments) }
  
  it 'name should be present' do
    item = Item.new(name: '', price: 100, brand_id: 1, category_id: 1)
    expect(item).to_not be_valid

    item = Item.new(name: 'Tab', price: 100, brand_id: 1, category_id: 1)
    expect(item).to be_valid
  end
  
  it 'brand_id should be present' do
    item = Item.new(name: 'Tab', price: 100, brand_id: '', category_id: 1)
    expect(item).to_not be_valid

    item = Item.new(name: 'Tab', price: 100, brand_id: 1, category_id: 1)
    expect(item).to be_valid
  end

  it 'category_id should be present' do
    item = Item.new(name: 'Tab', price: 100, brand_id: 1, category_id: '')
    expect(item).to_not be_valid

    item = Item.new(name: 'Tab', price: 100, brand_id: 1, category_id: 1)
    expect(item).to be_valid
  end

end
