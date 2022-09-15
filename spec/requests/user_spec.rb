# frozen_string_literal: true

require 'rails_helper'

RSpec.describe 'Users', type: :request do
  describe 'GET /new' do
    it 'renders a successful response for new user' do
      get new_user_url
      expect(response).to render_template('new')
    end
  end

  describe 'POST#create' do
    context 'with valid user attributes' do
      it 'successfully creates a new user' do
        expect do
          post users_path,
               params: { user: { name: 'John', email: 'test12@gmail.com',
                                 password: '123456', password_confirmation: '123456', mobile_no: '1234567890' } }
        end.to change(User, :count).by(1)
      end

      it 'redirects to the new user' do
        post users_path,
             params: { user: { name: 'John', email: '', password: '123456',
                               password_confirmation: '1456', mobile_no: '4567890' } }
        expect(response).to_not be_successful
      end
    end
  end

  describe 'GET#edit' do
    it 'redirects to the login page as user is not signed in' do
      user = create(:user)
      get edit_user_path(user)
      expect(response).to redirect_to(root_path)
    end

    it 'renders a successful response for edit user' do
      user = create(:user)
      post sign_in_url, params: { email: user.email, password: user.password }
      get edit_user_path(user)
      expect(response).to render_template('edit')
    end
  end

  describe 'GET#index' do
    it 'renders a successful response for index user for admin' do
      user = create(:admin)
      post sign_in_url, params: { email: user.email, password: user.password }
      get users_url
      expect(response).to render_template('index')
    end

    it 'redirects to the login page as user is not signed in' do
      user = create(:user)
      post sign_in_url, params: { email: user.email, password: user.password }
      get users_url
      expect(response).to redirect_to(root_path)
    end
  end
end
