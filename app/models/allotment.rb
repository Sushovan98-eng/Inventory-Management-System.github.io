# frozen_string_literal: true

class Allotment < ApplicationRecord
  include AllotmentsHelper
  belongs_to :user
  belongs_to :item

  default_scope { order(dealloted_at: :desc) }

  validates :user_id, presence: true
  validates :item_id, presence: true
  validates :allotment_quantity, presence: true, numericality: { only_integer: true, greater_than: 0 }
  validate :item_quantity_validation

  scope :user_allotments, -> { where(user_id: Current.user.id) }

  scope :allotment_of_item, ->(item_id) { order(dealloted_at: :desc).where(item_id: item_id) }
end
