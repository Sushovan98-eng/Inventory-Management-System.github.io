class Category < ApplicationRecord
    has_many :items, dependent: :nullify
    
    validates :name, presence: true, uniqueness: {case_sensitive: false}, length: { maximum: 30 }
    validates :description, presence: true, length: { maximum: 150 }
end
