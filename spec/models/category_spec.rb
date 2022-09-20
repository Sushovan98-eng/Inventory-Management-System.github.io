# frozen_string_literal: true

require 'rails_helper'

RSpec.describe Category, type: :model do
  it 'name should be present' do
    category = Category.new(name: '', description: 'This is sound system')
    expect(category).to_not be_valid

    category = Category.new(name: 'Speaker', description: 'This is sound system')
    expect(category).to be_valid
  end

  it 'description should be present' do
    category = Category.new(name: 'Speaker', description: '')
    expect(category).to_not be_valid

    category = Category.new(name: 'Speaker', description: 'This is sound system')
    expect(category).to be_valid
  end
end
