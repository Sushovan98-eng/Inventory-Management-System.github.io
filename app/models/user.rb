# frozen_string_literal: true

# This class is for User
class User < ApplicationRecord
  has_secure_password
  has_many :allotments, dependent: :destroy
  has_many :issues, dependent: :destroy

  before_save { self.email = email.downcase }
  validates :name,  presence: true, length: { maximum: 60 }
  validates :email, presence: true, length: { maximum: 150 },
                    format: { with: /\A[\w+\-.]+@[a-z\d\-.]+\.[a-z]+\z/i,
                              message: ' must be a valid email address' },
                    uniqueness: { case_sensitive: false }
  validates :mobile_no, presence: true,
                        format: { with: /\A[0-9]{10}\z/,
                                  message: ' must be a valid 10 digit number' }, uniqueness: true
  validates :password, presence: true, length: { minimum: 6 }, allow_nil: true

  scope :non_admins, -> { where(admin: false) }
end
