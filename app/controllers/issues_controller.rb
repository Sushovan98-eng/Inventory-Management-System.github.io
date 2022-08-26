class IssuesController < ApplicationController
  include SessionsHelper
  before_action :logged_in_user, only: [:index, :new, :show, :create, :solve_issue, :mark_as_solved]
  before_action :get_issue_by_id, only: [:show, :solve_issue, :mark_as_solved]
  before_action :admin_user, only: [:solve_issue, :mark_as_solved]

  
  def index
    if current_user.admin?
      @issues = Issue.admin_issues_order
    else
      @issues = Issue.user_issues_order
    end
  end

  def new
    @issue = Issue.new
  end

  def create
    @issue = Issue.new(user_id: current_user.id)
    @issue.assign_attributes(issue_params)
    if @issue.save
      redirect_to issues_path, flash: { notice: "Issue reported successfully." }
    else
      render :new, status: :unprocessable_entity
    end
  end

  def show
  end

  def solve_issue
  end

  def mark_as_solved
    data = issue_solve_params.merge(solved_at: DateTime.now)
    @user = User.find(@issue.user_id)
    if issue_solve_params[:feedback].blank?
      flash.now[:warning] = "Please provide feedback for the issue."
      render :solve_issue, status: :unprocessable_entity
    elsif @issue.update(data)
      redirect_to issues_path, flash: { notice: "Issue solved successfully." }
      NotificationMailer.issue_notification(@user, @issue).deliver_now
    else
      render :solve_issue, status: :unprocessable_entity
    end
  end

  private
    def issue_params
      params.require(:issue).permit(:item_id, :issue_description)
    end

    def issue_solve_params
      params.require(:issue).permit(:feedback)
    end

    def get_issue_by_id
      @issue = Issue.find(params[:id])
    end
end
