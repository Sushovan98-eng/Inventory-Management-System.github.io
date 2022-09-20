# frozen_string_literal: true

require 'rails_helper'

RSpec.describe Allotment, type: :model do
  before(:each) do
    @user = create(:user)
    @brand = create(:brand)
    @category = create(:category)
    @item = create(:item, brand_id: @brand.id, category_id: @category.id)
  end

  it 'user_id should be present' do
    allotment = Allotment.new(item_id: @item.id, allotment_quantity: 1)
    expect(allotment).to_not be_valid

    allotment = Allotment.new(user_id: @user.id, item_id: @item.id, allotment_quantity: 1)
    expect(allotment).to be_valid
  end

  it 'item_id should be present' do
    allotment = Allotment.new(user_id: @user.id, allotment_quantity: 1)
    expect(allotment).to_not be_valid

    allotment = Allotment.new(user_id: @user.id, item_id: @item.id, allotment_quantity: 1)
    expect(allotment).to be_valid
  end

  it 'allotment_quantity should be present and greater than 0' do
    allotment = Allotment.new(user_id: @user.id, item_id: @item.id)
    expect(allotment).to_not be_valid

    allotment = Allotment.new(user_id: @user.id, item_id: @item.id, allotment_quantity: 1)
    expect(allotment).to be_valid

    allotment = Allotment.new(user_id: @user.id, item_id: @item.id, allotment_quantity: 0)
    expect(allotment).to_not be_valid
  end
end
