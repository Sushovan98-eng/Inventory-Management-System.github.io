# frozen_string_literal: true

require 'rails_helper'

RSpec.describe 'Allotments', type: :request do
  before(:each) do
    @user = create(:user)
    @admin = create(:admin)
    @brand = create(:brand)
    @category = create(:category)
    @item = create(:item, brand_id: @brand.id, category_id: @category.id)
  end

  describe 'GET /new' do
    it 'renders a successful response for new allotment' do
      post sign_in_url, params: { email: @admin.email, password: @admin.password }
      get new_allotment_url
      expect(response).to render_template('new')
    end

    it 'redirects to the root page as user is not signed in' do
      get new_allotment_url
      expect(response).to redirect_to(root_path)
    end
  end

  describe 'POST#create' do
    context 'with valid allotment attributes' do
      it 'should create a new allotment' do
        post sign_in_url, params: { email: @admin.email, password: @admin.password }
        expect do
          post allotments_path,
               params: { allotment: { item_id: @item.id, allotment_quantity: 1, user_id: @user.id } }
        end.to change(Allotment, :count).by(1)
      end

      it 'redirects to the new allotment' do
        post sign_in_url, params: { email: @admin.email, password: @admin.password }
        post allotments_path,
             params: { allotment: { item_id: '', allotment_quantity: 10, user_id: @user.id } }
        expect(response).to_not be_successful
      end
    end
  end

  describe 'GET#deallot' do
    it 'renders a successful response for deallotment' do
      post sign_in_url, params: { email: @admin.email, password: @admin.password }
      allotment = create(:allotment, item_id: @item.id, user_id: @user.id)
      get deallot_allotment_path(allotment)
      expect(response).to redirect_to(allotments_path)
    end
  end

  it 'redirects to allotments page if allotment is already deallotted' do
    post sign_in_url, params: { email: @admin.email, password: @admin.password }
    allotment = create(:allotment, item_id: @item.id, user_id: @user.id, dealloted_at: Time.now)
    get deallot_allotment_path(allotment)
    expect(response).to redirect_to(allotments_path)
  end
end
