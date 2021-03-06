class AllotmentsController < ApplicationController
  include ApplicationHelper
  include SessionsHelper
  before_action :get_allotment_by_id, only: [:deallot, :edit, :update]
  before_action :get_item_by_item_id, only: [:deallot, :update]
  before_action :logged_in_user, only: [:index]
  before_action :admin_user, only: [:new, :edit, :update, :destroy, :deallot]
  before_action :get_edit_allotment_by_id, only: [:edit, :update]
  before_action :get_deallot, only: [:deallot]

    def index
      if current_user.admin?
        @allotments = Allotment.order(created_at: :asc).where(dealloted_at: nil)+(Allotment.order(dealloted_at: :desc).where.not(dealloted_at: nil))
      else
        @allotments = Allotment.order(created_at: :asc).where(dealloted_at: nil, user_id: current_user.id)+(Allotment.order(dealloted_at: :desc).where(user_id: current_user.id).where.not(dealloted_at: nil))
      end
    end
    
    def new
      @allotment = Allotment.new
      @non_admins = User.where(admin: false)
    end

    def create
      @allotment = Allotment.new(allotment_params)
      if Allotment.exists?(user_id: @allotment.user_id, item_id: @allotment.item_id, dealloted_at: nil)
        flash.now[:warning] =  "The specific user was recently alloted this product and has not been deallocated."
        render :new, status: :unprocessable_entity
      elsif @allotment.save
        successful_stock_update
        flash[:notice] = "Allotment made successfully."
      else
        render :new, status: :unprocessable_entity
      end
    end

    def edit
    end
  
    def update
      if @allotment.update(update_quantity_params)
        successful_stock_update
        @allotment.update_attribute(:created_at, Time.now)
        flash[:notice] = "Allotment updated successfully."
      else
        render :edit, status: :unprocessable_entity
      end
    end

    def deallot
      @item = Item.find(@allotment.item_id)
      if @allotment.update_attribute(:dealloted_at, Time.now)
        @item.update_attribute(:in_stock, (@item.in_stock + @allotment.allotment_quantity))
        redirect_to allotments_url
        flash[:success] =  "Item dealloted successfully."
      else
        redirect_to allotments_path
        flash[:warning] =  "Item deallotment failed."
      end
    end

    def users
      @allotment = Allotment.find(params[:id])
      @user = User.find(@allotment.user_id)
    end

  
    private
      def allotment_params
        params.require(:allotment).permit(:user_id, :item_id, :allotment_quantity)
      end
  
      def update_quantity_params
        params.require(:allotment).permit(:allotment_quantity)
      end
  
      def get_allotment_by_id
        @allotment = Allotment.find(params[:id])
      end
  
      def get_item_by_item_id
        @item = Item.find(@allotment.item_id)
      end
  
      def successful_stock_update
        @item = Item.find(@allotment.item_id)
        @item.in_stock = @item.total_stock - @allotment.allotment_quantity.to_i
        @item.update_attribute(:in_stock, @item.in_stock)
        redirect_to allotments_path
        notify_for_shortage_item(@item)
      end    
      
      def get_edit_allotment_by_id
        @allotment = Allotment.find(params[:id])
        if @allotment.dealloted_at != nil
          redirect_to allotments_path
          flash[:warning] = "This allotment has already been dealloted."
        end
      end

      def get_deallot
        @allotment = Allotment.find(params[:id])
        if @allotment.dealloted_at != nil
          redirect_to allotments_path
          flash[:warning] = "This allotment has already been dealloted."
        end
      end
end
