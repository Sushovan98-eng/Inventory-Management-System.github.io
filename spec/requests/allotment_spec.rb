# frozen_string_literal: true

require 'rails_helper'

RSpec.describe 'Allotments', type: :request do
  describe 'GET /new' do
    it 'renders a successful response for new allotment' do
      user = create(:admin)
      post sign_in_url, params: { email: user.email, password: user.password }
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
        admin = create(:admin)
        create(:user)
        create(:item)
        post sign_in_url, params: { email: admin.email, password: admin.password }
        expect do
          post allotments_path,
               params: { allotment: { item_id: 2, allotment_quantity: 1, user_id: 2 } }
        end.to change(Allotment, :count).by(1)
      end

      it 'redirects to the new allotment' do
        admin = create(:admin)
        post sign_in_url, params: { email: admin.email, password: admin.password }
        post allotments_path,
             params: { allotment: { item_id: '', allotment_quantity: 10, user_id: 1 } }
        expect(response).to_not be_successful
      end
    end
  end

  describe 'GET#deallot' do
    it 'renders a successful response for deallotment' do
      admin = create(:admin)
      post sign_in_url, params: { email: admin.email, password: admin.password }
      create(:user)
      create(:item)
      allotment = create(:allotment)
      get deallot_allotment_path(allotment)
      expect(response).to redirect_to(allotments_path)
    end
  end

  it 'redirects to allotments page if allotment is already deallotted' do
    admin = create(:admin)
    post sign_in_url, params: { email: admin.email, password: admin.password }
    create(:user)
    create(:item)
    allotment = create(:dealloted_allotment)
    get deallot_allotment_path(allotment)
    expect(response).to redirect_to(allotments_path)
  end
end
