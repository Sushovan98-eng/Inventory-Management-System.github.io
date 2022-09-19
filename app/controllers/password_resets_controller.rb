# frozen_string_literal: true

# This class is for Password Resets Controller
class PasswordResetsController < ApplicationController
  before_action :require_no_user

  @@token = nil
  @@reset = true

  def new; end

  def create
    @user = User.find_by(email: params[:email].downcase)
    if @user.present?
      # send an  email with the reset link
      @@token = generate_token
      PasswordMailer.with(user: @user, token: @@token).reset.deliver_now
      redirect_to root_path, notice: 'Email sent with password reset instructions.'
    else
      redirect_to password_reset_path, alert: 'Email not found.'
    end
  end

  def edit
    if @@token.nil? && @@reset == false
      redirect_to sign_in_path,
                  alert: 'You have already reset your password.
                  You can log in using your new password or generate a new password reset link.'
    else
      @user = User.find_signed!(@@token, purpose: 'password_reset')
    end
  rescue StandardError
    redirect_to root_path, alert: 'Invalid link.'
  end

  def update
    @user = User.find_signed!(@@token, purpose: 'password_reset')
    if password_blank
      redirect_to password_reset_edit_path, alert: 'Please enter a password and confirm it.'
    elsif @user.update(password_params)
      redirect_to sign_in_path, notice: 'Password has been reset.'
      @@token = nil
      @@reset = false
    else
      render :edit, status: :unprocessable_entity
    end
  end

  private

  def password_params
    params.require(:user).permit(:password, :password_confirmation)
  end

  def password_blank
    if params[:user][:password].blank? || params[:user][:password_confirmation].blank?
      true
    else
      false
    end
  end

  def require_no_user
    redirect_to root_path, alert: 'You are already logged in.' if current_user
  end

  def generate_token
    @token = @user.signed_id(purpose: 'password_reset', expires_in: 15.minutes)
    @token
  end
end
