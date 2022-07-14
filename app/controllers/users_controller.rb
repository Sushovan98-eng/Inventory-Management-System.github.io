class UsersController < ApplicationController
  include SessionsHelper
  before_action :logged_in_user, only: [:edit, :update, :destroy, :index]
  before_action :admin_user, only: [:make_admin_user, :remove_admin_user,:index]
  
    def index
      if current_user.admin?
        @users = User.all
      else
        redirect_to root_path, alert: "You are not authorized to view this page."
      end
    end

    def new
        @user = User.new
    end
    
    def create
      @user = User.new(user_params)
      if @user.save
        session[:user_id] = @user.id
        redirect_to root_path, notice: "Thank you for signing up!"
      else
        render :new, status: :unprocessable_entity
      end
    end

    def password_edit
        @user = Current.user
    end

    def password_update
        @user = Current.user
        if user_password_params[:password].blank? || user_password_params[:password_confirmation].blank?
            flash.now[:warning] =  "Please enter a password and confirm it."
            render :password_edit, status: :unprocessable_entity
        elsif @user.update(user_password_params)
            redirect_to @user, notice: "Password  updated successfully."
        else
            render :password_edit, status: :unprocessable_entity
        end
    end

    def edit
        @user = Current.user
    end

    def update
        @user = Current.user
        if @user.update(user_edit_params)
            redirect_to user_path, notice: "Profile updated successfully."
        else
            render :edit, status: :unprocessable_entity
        end
    end


    def show   
      @user = User.find(params[:id])   
    end

    def destroy
        @user = User.find(params[:id])
        @user.destroy
        redirect_to root_path, notice: "User was successfully deleted."
    end

    def current_allotment
      @allotments = Allotment.where({user_id: [params[:id]], dealloted_at: nil})
    end

    def make_admin_user 
      @user = User.find(params[:id])
      @user.update_attribute(:admin, true)
      redirect_to users_path, notice: "User was successfully made an admin."
    end

    def remove_admin_user
      @user = User.find(params[:id])
      @user.update_attribute(:admin, false)
      redirect_to users_path, notice: "User was successfully removed from admin."
    end

    private
      def user_params
        params.require(:user).permit(:name, :email, :mobile_no, :password, :password_confirmation)
      end

      def user_password_params
          params.require(:user).permit(:password, :password_confirmation)
      end
      
      def user_edit_params
          params.require(:user).permit(:name, :email, :mobile_no)
      end
end
