# frozen_string_literal: true

require 'rails_helper'

RSpec.describe 'Items', type: :request do
  before(:each) do
    @brand = create(:brand)
    @category = create(:category)
    @admin = create(:admin)
  end

  describe 'GET /new' do
    it 'renders a successful response for new item' do
      post sign_in_url, params: { email:  @admin.email, password: @admin.password }
      get new_item_url
      expect(response).to render_template('new')
    end

    it 'redirects to the root page as user is not signed in' do
      get new_item_url
      expect(response).to redirect_to(root_path)
    end
  end

  describe 'POST#create' do
    context 'with valid item attributes' do
      it 'should create a new item' do
        post sign_in_url, params: { email: @admin.email, password: @admin.password }
        expect do
          post items_path,
               params: { item: { name: 'Yoga 9i', category_id: @category.id,
                                 brand_id: @brand.id, price: 100, total_stock: 10 } }
        end.to change(Item, :count).by(1)
      end

      it 'redirects to the new item' do
        post sign_in_url, params: { email: @admin.email, password: @admin.password }
        post items_path, params: { item: { name: '', category_id: '',
                                           brand_id: @brand.id, price: 100, total_stock: 10 } }
        expect(response).to_not be_successful
      end
    end
  end

  describe 'GET#edit' do
    it 'redirects to the root page as admin user is not signed in' do
      item = create(:item, brand_id: @brand.id, category_id: @category.id)

      get edit_item_path(item)
      expect(response).to redirect_to(root_path)
    end

    it 'renders a successful response for edit item' do
      post sign_in_url, params: { email:  @admin.email, password: @admin.password }
      item = create(:item, brand_id: @brand.id, category_id: @category.id)
      get edit_item_path(item)
      expect(response).to render_template('edit')
    end
  end

  describe 'GET#destroy' do
    it 'redirects to the root page as admin user is not signed in' do
      item = create(:item, brand_id: @brand.id, category_id: @category.id)
      delete item_path(item)
      expect(response).to redirect_to(root_path)
    end

    it 'should delete an item' do
      post sign_in_url, params: { email: @admin.email, password: @admin.password }
      item = create(:item, brand_id: @brand.id, category_id: @category.id)
      expect do
        delete item_path(item)
      end.to change(Item, :count).by(-1)
    end
  end
end
