require 'rails_helper'

RSpec.describe "Issues", type: :request do
  
  before(:each) do
    @user = create(:user)
    @brand = create(:brand)
    @category = create(:category)
    @item = create(:item, brand_id: @brand.id, category_id: @category.id)
  end


  describe "GET /new" do 
    it "renders a successful response for new item" do
      post sign_in_url, params: { email: @user.email, password: @user.password }
      get new_issue_url
      expect(response).to render_template('new')
    end
  end

  describe "GET /solve_issue" do
    it "renders a successful response for solve_issue" do
      issue = create(:issue, user_id: @user.id, item_id: @item.id)
      admin = create(:admin)
      post sign_in_url, params: { email: admin.email, password: admin.password }
      get solve_issue_issue_url(issue)
      expect(response).to render_template('solve_issue')
    end

    it "should not responce for solve issue" do
      issue = create(:issue, user_id: @user.id, item_id: @item.id)
      post sign_in_url, params: { email: @user.email, password: @user.password }
      get solve_issue_issue_url(issue)
      expect(response).to_not render_template('solve_issue')
    end
  end

end
