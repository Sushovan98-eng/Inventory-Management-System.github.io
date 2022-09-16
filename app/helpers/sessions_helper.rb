# frozen_string_literal: true

# Here define the Session helper methods for the application
module SessionsHelper
  # def current_user
  #   if (user_id = session[:user_id])
  #     @current_user ||= User.find_by(id: user_id)
  #   elsif (user_id = cookies.signed[:user_id])
  #     user = User.find_by(id: user_id)
  #     if user&.authenticated?(cookies[:remember_token])
  #       log_in user
  #       @current_user = user
  #     end
  #   end
  # end

  def current_user
    Current.user
  end

  def logged_in?
    !current_user.nil?
  end

  def logged_in_user
    return if logged_in?

    flash[:alert] = 'Please log in FIRST.'
    redirect_to root_path
  end

  def admin_user
    return if current_user.admin

    flash[:alert] = 'You are not authorized to perform this action.'
    redirect_to root_path and return
  end
end
