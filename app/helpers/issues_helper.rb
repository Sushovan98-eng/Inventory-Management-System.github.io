module IssuesHelper
    def unsolved_issues_count
        if current_user.admin?
        @unsolved_issues_count = Issue.where(solved_at: nil).count
        else
        @unsolved_issues_count = Issue.where(user_id: current_user.id, solved_at: nil).count
        end
    end 
end
