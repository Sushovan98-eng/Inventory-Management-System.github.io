# frozen_string_literal: true

require 'rails_helper'

RSpec.describe Item, type: :model do
  it 'name should be present' do
    item = Item.new(id: 1, name: '', price: 100, brand_id: 1, category_id: 1, total_stock: 10)
    expect(item).to_not be_valid

    item = Item.new(id: 1, name: 'Tab', price: 100, brand_id: 1, category_id: 1, total_stock: 10)
    expect(item).to be_valid
  end

  it 'brand_id should be present' do
    item = Item.new(id: 2, name: 'Tab', price: 100, brand_id: '', category_id: 1, total_stock: 10)
    expect(item).to_not be_valid

    item = Item.new(id: 2, name: 'Tab', price: 100, brand_id: 1, category_id: 1, total_stock: 10)
    expect(item).to be_valid
  end

  it 'category_id should be present' do
    item = Item.new(id: 3, name: 'Tab', price: 100, brand_id: 1, category_id: '', total_stock: 10)
    expect(item).to_not be_valid

    item = Item.new(id: 3, name: 'Tab', price: 100, brand_id: 1, category_id: 1, total_stock: 10)
    expect(item).to be_valid
  end
end
