# frozen_string_literal: true

require 'rails_helper'

RSpec.describe Item, type: :model do
  before(:each) do
    @brand = create(:brand)
    @category = create(:category)
  end

  it 'name should be present' do
    item = Item.new(name: '', price: 100, brand_id: @brand.id, category_id: @category.id, total_stock: 10)
    expect(item).to_not be_valid

    item = Item.new(name: 'Tab', price: 100, brand_id: @brand.id, category_id: @category.id, total_stock: 10)
    expect(item).to be_valid
  end

  it 'brand_id should be present' do
    item = Item.new(name: 'Tab', price: 100, brand_id: '', category_id: @category.id, total_stock: 10)
    expect(item).to_not be_valid

    item = Item.new(name: 'Tab', price: 100, brand_id: @brand.id, category_id: @category.id, total_stock: 10)
    expect(item).to be_valid
  end

  it 'category_id should be present' do
    item = Item.new(name: 'Tab', price: 100, brand_id: @brand.id, category_id: '', total_stock: 10)
    expect(item).to_not be_valid

    item = Item.new(name: 'Tab', price: 100, brand_id: @brand.id, category_id: @category.id, total_stock: 10)
    expect(item).to be_valid
  end
end
