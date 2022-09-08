# frozen_string_literal: true

# This class is for Application Controller
class ApplicationController < ActionController::Base
  include SessionsHelper

  before_action :set_current_user

  def set_current_user
    Current.user = User.find_by(id: session[:user_id]) if session[:user_id]
  end

  def require_user_logged_in!
    redirect_to sign_in_path, alert: 'You must be logged in to do that.' if Current.user.nil?
  end
end
