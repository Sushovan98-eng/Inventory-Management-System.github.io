class Allotment < ApplicationRecord
    belongs_to :user
    belongs_to :item
    validates :user_id, :item_id, :allotment_quantity, presence: true
        
    attribute :allotment_quantity, default: 0
    
end
