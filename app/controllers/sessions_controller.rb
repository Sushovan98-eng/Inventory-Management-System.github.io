class SessionsController < ApplicationController
    def new
    end
    
    def create
        @user = User.find_by(email: params[:email].downcase)
        if @user && @user.authenticate(params[:password])
        session[:user_id] = @user.id
        redirect_to root_path, notice: "You have been logged in."
        else
        flash[:alert] = "Invalid Email or Password."
        redirect_to sign_in_path, status: :unprocessable_entity
        end
    end
 
  def destroy
    session[:user_id] = nil
    redirect_to root_path 
    flash[:warning] =  "You have been logged out."
  end
end
