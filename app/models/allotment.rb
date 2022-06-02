class Allotment < ApplicationRecord
    include AllotmentsHelper
    belongs_to :user
    belongs_to :item
    
    validates :user_id, presence: true
    validates :item_id, presence: true
    validates :allotment_quantity, presence: true, numericality: { only_integer: true, greater_than: 0 }
    validate :item_quantity_validation
    validate :allotment_exsist
end
