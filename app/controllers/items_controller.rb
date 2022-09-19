# frozen_string_literal: true

# This class is for Items Controller
class ItemsController < ApplicationController
  include ApplicationHelper
  before_action :logged_in_user, only: %i[index new create edit update show destroy]
  before_action :item_by_id, only: %i[edit update show]
  before_action :admin_user, only: %i[destroy new create edit update]

  def index
    @q = Item.ransack(params[:q])
    @items = @q.result(distinct: true)
  end

  def new
    @item = Item.new
  end

  def create
    item_data = item_params.merge(in_stock: item_params[:total_stock])
    @item = Item.new(item_data)
    if @item.save
      redirect_to items_path, notice: 'Item created successfully.'
    else
      render :new, status: :unprocessable_entity
    end
  end

  def edit
    @@previous_request = request.env['HTTP_REFERER']
  end

  def show
    @brand_name = @item.brand_id.nil? ? '<--Null-->' : Brand.find(@item.brand_id).name
    @category_name = @item.category_id.nil? ? '<--Null-->' : Category.find(@item.category_id).name
  end

  def update
    previous_quantity = @item.total_stock
    if (item_params[:total_stock].to_i - previous_quantity + @item.in_stock).negative?
      redirect_to edit_item_path(@item), flash: { warning: 'Currently more items are alloted than entered value.' }
    elsif @item.update(item_params)
      redirect_to @@previous_request, flash: { notice: 'Item updated successfully.' }
      update_stock(@item, previous_quantity)
    else
      render :edit, status: :unprocessable_entity
    end
  end

  def destroy
    Item.find(params[:id]).destroy
    redirect_to items_path
    flash[:warning] = 'Item has been deleted.'
  end

  def new_stock
    @item = Item.find(params[:id])
  end

  def increase_stock
    @item = Item.find(params[:id])
    @item.total_stock, @item.in_stock = add_new_stock(@item, item_params[:new_stock].to_i)
    if @item.save
      redirect_to items_path
      flash[:warning] = 'Stock increased successfully.'
    else
      render :new_stock, status: :unprocessable_entity
    end
  end

  def item_allotments
    @allotments = Allotment.allotment_of_item(params[:id])
  end

  def new_allotment
    @item = Item.find(params[:id])
    @allotment = Allotment.new
    @non_admins = User.non_admins
  end

  private

  def item_params
    params.require(:item).permit(:name, :category_id, :brand_id, :price, :total_stock, :minimum_required_stock,
                                 :new_stock)
  end

  def item_by_id
    @item = Item.find(params[:id])
  end

  def update_stock(item, previous_quantity)
    item.in_stock += item.total_stock - previous_quantity
    item.update_attribute(:in_stock, item.in_stock)
  end

  def add_new_stock(item, new_stock)
    item.total_stock += new_stock
    item.in_stock += new_stock
    [item.total_stock, item.in_stock]
  end
end
