class Issue < ApplicationRecord
    belongs_to :user
    belongs_to :item
    validates :issue_description, presence: true, length: { maximum: 500 }
end
