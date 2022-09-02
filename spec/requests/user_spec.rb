require 'rails_helper'

RSpec.describe "Users", type: :request do

  describe "GET /users/new" do
    it "works! (now write some real specs)" do
      get new_user_path
      expect(response).to have_http_status(200)
    end
  end

  describe "GET /users" do
    it "works! (now write some real specs)" do
      get users_path
      expect(response).to have_http_status(302)
    end
  end

  

end
