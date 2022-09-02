require 'rails_helper'

RSpec.describe Category, type: :model do
  it 'name should be present' do
    category = Category.new(name: '', description: 'Test')
    expect(category).to_not be_valid

    category = Category.new(name: 'Test1', description: 'Test')
    expect(category).to be_valid
  end

  it 'description should be present' do
    category = Category.new(name: 'Test', description: '')
    expect(category).to_not be_valid

    category = Category.new(name: 'Test1', description: 'Test')
    expect(category).to be_valid
  end
end
