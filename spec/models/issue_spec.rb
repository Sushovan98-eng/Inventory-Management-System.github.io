require 'rails_helper'

RSpec.describe Issue, type: :model do
  
  before(:each) do
    @user = create(:user)
    @brand = create(:brand)
    @category = create(:category)
    @item = create(:item, brand_id: @brand.id, category_id: @category.id)
  end

  it 'item_id should be present' do
    issue = Issue.new(user_id: @user.id, item_id: '', issue_description: 'MyString')
    expect(issue).to_not be_valid

    issue = Issue.new(user_id: @user.id, item_id: @item.id, issue_description: 'MyString')
    expect(issue).to be_valid
  end

  it 'issue_description should be present' do
    issue = Issue.new(user_id: @user.id, item_id: @item.id, issue_description: '')
    expect(issue).to_not be_valid

    issue = Issue.new(user_id: @user.id, item_id: @item.id, issue_description: 'MyString')
    expect(issue).to be_valid
  end
end
