# frozen_string_literal: true

class Issue < ApplicationRecord
  belongs_to :user
  belongs_to :item
  validates :item_id, presence: true
  validates :issue_description, presence: true, length: { maximum: 500 }

  default_scope { order(created_at: :desc) }

  scope :user_issues, -> { where(user_id: Current.user.id) }
end
