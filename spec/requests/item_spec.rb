# frozen_string_literal: true

require 'rails_helper'

RSpec.describe 'Items', type: :request do
  describe 'GET /new' do
    it 'renders a successful response for new item' do
      user = create(:admin)
      post sign_in_url, params: { email: user.email, password: user.password }
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
        user = create(:admin)
        create(:brand)
        create(:category)
        post sign_in_url, params: { email: user.email, password: user.password }
        expect do
          post items_path,
               params: { item: { name: 'Item', category_id: 2,
                                 brand_id: 2, price: 100, total_stock: 10 } }
        end.to change(Item, :count).by(1)
      end

      it 'redirects to the new item' do
        user = create(:admin)
        post sign_in_url, params: { email: user.email, password: user.password }
        post items_path, params: { item: { name: '', category_id: '',
                                           brand_id: 1, price: 100, total_stock: 10 } }
        expect(response).to_not be_successful
      end
    end
  end

  describe 'GET#edit' do
    it 'redirects to the root page as admin user is not signed in' do
      create(:brand)
      create(:category)
      item = create(:item)
      get edit_item_path(item)
      expect(response).to redirect_to(root_path)
    end

    it 'renders a successful response for edit item' do
      user = create(:admin)
      create(:brand)
      create(:category)
      post sign_in_url, params: { email: user.email, password: user.password }
      item = create(:item)
      get edit_item_path(item)
      expect(response).to render_template('edit')
    end
  end

  describe 'GET#destroy' do
    it 'redirects to the root page as admin user is not signed in' do
      create(:brand)
      create(:category)
      item = create(:item)
      delete item_path(item)
      expect(response).to redirect_to(root_path)
    end

    it 'should delete an item' do
      user = create(:admin)
      create(:brand)
      create(:category)
      post sign_in_url, params: { email: user.email, password: user.password }
      item = create(:item)
      expect do
        delete item_path(item)
      end.to change(Item, :count).by(-1)
    end
  end
end
