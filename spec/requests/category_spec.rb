# frozen_string_literal: true

require 'rails_helper'

RSpec.describe 'Categories', type: :request do
  describe 'GET /new' do
    it 'renders a successful response for new category' do
      user = create(:admin)
      post sign_in_url, params: { email: user.email, password: user.password }
      get new_category_url
      expect(response).to render_template('new')
    end

    it 'redirects to the login page as user is not signed in' do
      get new_category_url
      expect(response).to redirect_to(root_path)
    end
  end

  describe 'POST#create' do
    context 'with valid category attributes' do
      it 'should create a new category' do
        user = create(:admin)
        post sign_in_url, params: { email: user.email, password: user.password }
        expect do
          post categories_path, params: { category: { name: 'Category',
                                                      description: 'Description' } }
        end.to change(Category, :count).by(1)
      end

      it 'redirects to the new category' do
        user = create(:admin)
        post sign_in_url, params: { email: user.email, password: user.password }
        post categories_path, params: { category: { name: '' } }
        expect(response).to_not be_successful
      end
    end
  end

  describe 'GET#edit' do
    it 'redirects to the root page as admin user is not signed in' do
      category = create(:category)
      get edit_category_path(category)
      expect(response).to redirect_to(root_path)
    end

    it 'renders a successful response for edit category' do
      user = create(:admin)
      post sign_in_url, params: { email: user.email, password: user.password }
      category = create(:category)
      get edit_category_path(category)
      expect(response).to render_template('edit')
    end
  end

  describe 'GET#destroy' do
    it 'redirects to the root page as admin user is not signed in' do
      category = create(:category)
      delete category_path(category)
      expect(response).to redirect_to(root_path)
    end
  end
end
