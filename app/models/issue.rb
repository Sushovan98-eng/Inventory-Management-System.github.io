class Issue < ApplicationRecord
    belongs_to :user
    belongs_to :item
    validates :item_id, presence: true
    validates :issue_description, presence: true, length: { maximum: 500 }
end
