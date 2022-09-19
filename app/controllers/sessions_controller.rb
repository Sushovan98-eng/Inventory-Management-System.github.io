# frozen_string_literal: true

# This class is for Sessions Controller
class SessionsController < ApplicationController
  def new; end

  def create
    @user = User.find_by(email: session_params[:email].downcase)

    if @user&.authenticate(session_params[:password])
      session[:user_id] = @user.id
      redirect_to root_path, notice: 'You have been logged in.'
    else
      flash[:alert] = 'Invalid Email or Password.'
      redirect_to sign_in_path, status: :unprocessable_entity
    end
  end

  def destroy
    session[:user_id] = nil
    redirect_to root_path
    flash[:warning] = 'You have been logged out.'
  end

  private

  def session_params
    params.permit(:email, :password, :authenticity_token, :commit)
  end
end
