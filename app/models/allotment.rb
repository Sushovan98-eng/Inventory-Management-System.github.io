class Allotment < ApplicationRecord
    belongs_to :user
    belongs_to :item
    validates :user_id, presence: true
    validates :item_id, presence: true
    validates :allotment_quantity, presence: true
        
    attribute :allotment_quantity, default: 0
    
end
