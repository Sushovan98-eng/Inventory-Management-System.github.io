# frozen_string_literal: true

module IssuesHelper
  def unsolved_issues_count
    @unsolved_issues_count = if current_user.admin?
                               Issue.where(solved_at: nil).count
                             else
                               Issue.where(user_id: current_user.id, solved_at: nil).count
                             end
  end
end
