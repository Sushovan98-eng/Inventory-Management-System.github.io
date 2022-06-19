class PasswordResetsController < ApplicationController
  before_action :require_no_user
  
  def new 
  end

  def create
    @user = User.find_by(email: params[:email].downcase)
    if @user.present?
      #send an  email
      PasswordMailer.with(user: @user).reset.deliver_now
      redirect_to root_path, notice: "Email sent with password reset instructions."
    else
      redirect_to password_reset_path, alert: "Email not found."
    end
    
  end  

  def edit
    @user = User.find_signed!(params[:token], purpose: "password_reset")
  rescue ActiveSupport::MessageVerifier::InvalidSignature
    redirect_to root_path, alert: "Invalid password reset token.", status: :unprocessable_entity
  end

  def update
    @user = User.find_signed!(params[:token], purpose: "password_reset")
    if @user.update(password_params)
      redirect_to sign_in_path, notice: "Password has been reset."
    else
      render :edit, status: :unprocessable_entity
    end
  end

  private
  def password_params
    params.require(:user).permit(:password, :password_confirmation)
  end

  def require_no_user
    if current_user
      redirect_to root_path, alert: "You are already logged in."
    end
  end
end