class AllotmentsController < ApplicationController
  include ApplicationHelper
  include SessionsHelper
  before_action :get_allotment_by_id, only: [:deallot, :edit, :update]
  before_action :get_item_by_item_id, only: [:deallot, :update]
  before_action :logged_in_user, only: [:index]
  before_action :admin_user, only: [:new, :edit, :update, :destroy, :deallot]

    def index
      if current_user.admin?
        @allotments = Allotment.all
      else
        @allotments = Allotment.where(user_id: current_user.id)
      end
    end
    
    def new
      @allotment = Allotment.new
      @non_admins = User.where(admin: false)
    end
  
    def create
      @allotment = Allotment.new(allotment_params)
      if Allotment.exists?(user_id: @allotment.user_id, item_id: @allotment.item_id, dealloted_at: nil)
        render :new
        flash[:warning] = "The specific user was recently alloted this product and has not been deallocated." 
      else
        @item = Item.find(@allotment.item_id)
        if @item.in_stock < @allotment.allotment_quantity.to_i
          @non_admins = User.where(admin: false)
          redirect_to new_allotment_path
          flash[:warning] =  "Total stock of this item is NOT sufficient for this allotment." 
        elsif @allotment.save
          successful_stock_update
        else
          render :new
        end
      end
    end
  
    def edit
    end
  
    def update
      @item = Item.find(@allotment.item_id)
      if @item.in_stock < update_quantity_params[:allotment_quantity].to_i
        redirect_to edit_allotment_path(@item)
        flash[:warning] =  "Total stock of this item is NOT sufficient for this allotment." 
      elsif @allotment.update(update_quantity_params)
        successful_stock_update
      else
        render :edit
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
        @item.in_stock = @item.total_stock - @allotment.allotment_quantity.to_i
        @item.update_attribute(:in_stock, @item.in_stock)
        redirect_to allotments_path, notice: "Allotment quantity updated successfully."
        notify_for_shortage_item(@item)
      end
end
