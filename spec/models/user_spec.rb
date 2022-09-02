require 'rails_helper'

RSpec.describe User, type: :model do

    # it{ should have_many(:issue) }
    # it{ should have_many(:allotment) }


    it 'name should be present' do
      user = User.new(name: '', email: 'test@gmail.com', mobile_no: '7644837568', password: 'Test@1', password_confirmation: 'Test@1')
      expect(user).to_not be_valid
      

      user = User.new(name: 'Test', email: 'test@gmail.com', mobile_no: '7644837568', password: 'Test@1', password_confirmation: 'Test@1')
      expect(user).to be_valid
    end

    it 'email should be present' do
        user = User.new(name: 'Test', email: '', mobile_no: '7644837568', password: 'Test@1', password_confirmation: 'Test@1')
        expect(user).to_not be_valid
        

        user = User.new(name: 'Test', email: 'test@gmail.com', mobile_no: '7644837568', password: 'Test@1', password_confirmation: 'Test@1')
        expect(user).to be_valid            

        user = User.new(name: 'Test', email: 'abc', mobile_no: '7644837568', password: 'Test@1', password_confirmation: 'Test@1')
        expect(user).to_not be_valid
    end

    it 'mobile_no should be present' do
        user = User.new(name: 'Test', email: 'test@gmail.com', mobile_no: '', password: 'Test@1', password_confirmation: 'Test@1')
        expect(user).to_not be_valid

        user = User.new(name: 'Test', email: 'test@gmail.com', mobile_no: '76448', password: 'Test@1', password_confirmation: 'Test@1')
        expect(user).to_not be_valid

        user = User.new(name: 'Test', email: 'test@gmail.com', mobile_no: '7644837568', password: 'Test@1', password_confirmation: 'Test@1')
        expect(user).to be_valid
    end

    it 'password should be present' do
        user = User.new(name: 'Test', email: 'test@gmail.com', mobile_no: '7644837568', password: '', password_confirmation: 'Test@1')
        expect(user).to_not be_valid

        user = User.new(name: 'Test', email: 'test@gmail.com', mobile_no: '7644837568', password: 'Test', password_confirmation: 'Test')
        expect(user).to_not be_valid

        user = User.new(name: 'Test', email: 'test@gmail.com', mobile_no: '7644837568', password: 'Test@1', password_confirmation: 'Test@1')
        expect(user).to be_valid
    end

end
