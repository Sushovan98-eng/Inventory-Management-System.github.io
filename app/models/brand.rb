class Brand < ApplicationRecord
  has_many :items, dependent: :nullify

  validates :name, presence: true, uniqueness: {case_sensitive: false}, length: { maximum: 30 }
  validates :manufacturer_email, presence: true, length: { maximum: 150 }, format: { with: /\A[\w+\-.]+@[a-z\d\-.]+\.[a-z]+\z/i}, uniqueness: { case_sensitive: false }

  scope :ordered_by_name, -> { order(:name) }

end
