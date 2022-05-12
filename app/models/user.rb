class User < ApplicationRecord
    has_secure_password

    validates :name,  presence: true, length: { maximum: 60 }
    validates :email, presence: true, length: { maximum: 150 }, format: { with: /\A[\w+\-.]+@[a-z\d\-.]+\.[a-z]+\z/i, message: "Email must be a valid email address"}, uniqueness: { case_sensitive: false }
    validates :password, presence: true, length: { minimum: 6 }
end
