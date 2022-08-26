class Issue < ApplicationRecord
    belongs_to :user
    belongs_to :item
    validates :item_id, presence: true
    validates :issue_description, presence: true, length: { maximum: 500 }

    
    scope :admin_issues_order, -> { order(created_at: :asc).where(solved_at: nil)+(Issue.order(solved_at: :desc).where.not(solved_at: nil)) }
    
    scope :user_issues_order, -> { order(created_at: :asc).where(solved_at: nil, user_id: Current.user.id)+(Issue.order(solved_at: :desc).where(user_id: Current.user.id).where.not(solved_at: nil)) }
end
