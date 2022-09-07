# frozen_string_literal: true

class Issue < ApplicationRecord
  belongs_to :user
  belongs_to :item
  validates :item_id, presence: true
  validates :issue_description, presence: true, length: { maximum: 500 }

  default_scope { order(created_at: :desc) }

  scope :user_issues, -> { where(user_id: Current.user.id) }
  
  scope :solved_status_search, -> (search) do
    if search == "solved"
      where("solved_at IS NOT NULL")
    elsif search == "unsolved"
      where("solved_at IS NULL")
    end
  end
  

  def self.ransackable_scopes(auth_object = nil)
    [:solved_status_search]
  end  

end
