# frozen_string_literal: true

require 'rails_helper'

RSpec.describe 'Brands', type: :request do
  before(:each) do
    @admin = create(:admin)
  end
  describe 'GET /new' do
    it 'renders a successful response for new brand' do
      post sign_in_url, params: { email: @admin.email, password: @admin.password }
      get new_brand_url
      expect(response).to render_template('new')
    end

    it 'redirects to the login page as user is not signed in' do
      get new_brand_url
      expect(response).to redirect_to(root_path)
    end
  end

  describe 'POST#create' do
    context 'with valid brand attributes' do
      it 'should create a new brand' do
        post sign_in_url, params: { email: @admin.email, password: @admin.password }
        expect do
          post brands_path,
               params: { brand: { name: 'Canon', manufacturer: 'Canon Manufacturer',
                                  manufacturer_email: 'canon@gmail.com',
                                  manufacturer_office: 'Kolkata' } }
        end.to change(Brand, :count).by(1)
      end

      it 'redirects to the new brand' do
        post sign_in_url, params: { email: @admin.email, password: @admin.password }
        post brands_path,
             params: { brand: { name: '', manufacturer: 'Canon Manufacturer',
                                manufacturer_email: 'canon@gmail.com',
                                manufacturer_office: 'Kolkata' } }
        expect(response).to_not be_successful
      end
    end
  end

  describe 'GET#edit' do
    it 'redirects to the root page as admin user is not signed in' do
      brand = create(:brand)
      get edit_brand_path(brand)
      expect(response).to redirect_to(root_path)
    end

    it 'renders a successful response for edit brand' do
      post sign_in_url, params: { email: @admin.email, password: @admin.password }
      brand = create(:brand)
      get edit_brand_path(brand)
      expect(response).to render_template('edit')
    end
  end

  describe 'GET#destroy' do
    it 'redirects to the root page as admin user is not signed in' do
      brand = create(:brand)
      delete brand_path(brand)
      expect(response).to redirect_to(root_path)
    end

    it 'redirects to the brands page after deleting a brand' do
      post sign_in_url, params: { email: @admin.email, password: @admin.password }
      brand = create(:brand)
      delete brand_path(brand)
      expect(response).to redirect_to(brands_path)
    end
  end
end
