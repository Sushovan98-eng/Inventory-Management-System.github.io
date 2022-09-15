# frozen_string_literal: true

# # This class is for Allotment Controller

class AllotmentsController < ApplicationController
  include ApplicationHelper
  include SessionsHelper
  before_action :allotment_by_id, only: %i[deallot edit update]
  before_action :item_by_item_id, only: %i[deallot update]
  before_action :logged_in_user, only: %i[index new]
  before_action :admin_user, only: %i[new edit update destroy deallot]
  before_action :deallot_status, only: [:deallot]

  def index
    @q = Allotment.ransack(params[:q])
    @allotments = if current_user.admin
                    @q.result(distinct: true)
                  else
                    @q.result(distinct: true).user_allotments
                  end
  end

  def new
    @allotment = Allotment.new
    @non_admins = User.non_admins
  end

  def create
    @allotment = Allotment.new(allotment_params)
    if Allotment.exists?(user_id: @allotment.user_id, item_id: @allotment.item_id, dealloted_at: nil)
      flash.now[:warning] = 'The specific user was recently alloted this product and has not been deallocated.'
      render :new, status: :unprocessable_entity
    elsif @allotment.save
      successful_stock_update
      flash[:notice] = 'Allotment made successfully.'
    else
      render :new, status: :unprocessable_entity
    end
  end

  def deallot
    @item = Item.find(@allotment.item_id)
    respond_to do |format|
      if @allotment.update_attribute(:dealloted_at, Time.now)
        @item.update_attribute(:in_stock, (@item.in_stock + @allotment.allotment_quantity))
        format.html { redirect_to allotments_path, notice: 'Allotment dealloted successfully.' }
      else
        format.html { redirect_to allotments_path, notice: 'Allotment deallocation failed.' }
      end
      format.js
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

  def allotment_by_id
    @allotment = Allotment.find(params[:id])
  end

  def item_by_item_id
    @item = Item.find(@allotment.item_id)
  end

  def successful_stock_update
    @item = Item.find(@allotment.item_id)
    @item.in_stock = @item.in_stock - @allotment.allotment_quantity.to_i
    @item.update_attribute(:in_stock, @item.in_stock)
    redirect_to allotments_path
    notify_for_shortage_item(@item)
  end

  def deallot_status
    @allotment = Allotment.find(params[:id])
    unless @allotment.dealloted_at.nil?
      redirect_to allotments_path
      flash[:warning] = 'This allotment has been dealloted.'
    end
  end
end
