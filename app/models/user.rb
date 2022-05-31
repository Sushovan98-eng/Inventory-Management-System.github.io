class User < ApplicationRecord
    has_secure_password
    has_many :allotments, dependent: :destroy
    has_many :issues, dependent: :destroy

    before_save { self.email = email.downcase }
    validates :name,  presence: true, length: { maximum: 60 }
    validates :email, presence: true, length: { maximum: 150 }, format: { with: /\A[\w+\-.]+@[a-z\d\-.]+\.[a-z]+\z/i, message: "Email must be a valid email address"}, uniqueness: { case_sensitive: false }
    validates :mobile_no, presence: true, length: { maximum: 10 }
    validates :password, presence: true, length: { minimum: 6 }
end
