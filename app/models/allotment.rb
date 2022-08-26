class Allotment < ApplicationRecord
    include AllotmentsHelper
    belongs_to :user
    belongs_to :item
    
    validates :user_id, presence: true
    validates :item_id, presence: true
    validates :allotment_quantity, presence: true, numericality: { only_integer: true, greater_than: 0 }
    validate :item_quantity_validation


    scope :admin_allotments_order, -> { order(created_at: :asc).where(dealloted_at: nil)+(Allotment.order(dealloted_at: :desc).where.not(dealloted_at: nil)) }

    scope :user_allotments_order, -> { order(created_at: :asc).where(dealloted_at: nil, user_id: Current.user.id)+(Allotment.order(dealloted_at: :desc).where(user_id: Current.user.id).where.not(dealloted_at: nil)) }
end
