# frozen_string_literal: true

require 'rails_helper'

RSpec.describe Allotment, type: :model do
  it 'user_id should be present' do  
    allotment = Allotment.new(item_id: 1, allotment_quantity: 1)
    expect(allotment).to_not be_valid

    create(:user3)
    create(:brand4)
    create(:category)
    create(:item3)
    allotment = Allotment.new(user_id: 3, item_id: 3, allotment_quantity: 1)
    expect(allotment).to be_valid
  end

  it 'item_id should be present' do
    allotment = Allotment.new(user_id: 1, allotment_quantity: 1)
    expect(allotment).to_not be_valid

    create(:user)
    create(:brand)
    create(:category)
    create(:item) 
    allotment = Allotment.new(user_id: 2, item_id: 2, allotment_quantity: 1)
    expect(allotment).to be_valid
  end

  it 'allotment_quantity should be present and greater than 0' do
    allotment = Allotment.new(user_id: 1, item_id: 1)
    expect(allotment).to_not be_valid

    create(:user)
    create(:brand)
    create(:category)
    create(:item) 
    allotment = Allotment.new(user_id: 2, item_id: 2, allotment_quantity: 1)
    expect(allotment).to be_valid

    allotment = Allotment.new(user_id: 1, item_id: 1, allotment_quantity: 0)
    expect(allotment).to_not be_valid
  end
end
