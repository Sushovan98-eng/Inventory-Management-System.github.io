class UsersController < ApplicationController
  include SessionsHelper
  
  
    def index
      if current_user.admin?
        @users = User.all
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
        render :new
      end
    end

    def edit
        @user = Current.user
    end

    def update
        if Current.user.update(user_edit_params)
            redirect_to root_path, notice: "Password was successfully updated."
        else
            render :edit
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

    private
      def user_params
        params.require(:user).permit(:name, :email, :mobile_no, :password, :password_confirmation)
      end

      def user_edit_params
          params.require(:user).permit(:password, :password_confirmation)
      end
      
end
