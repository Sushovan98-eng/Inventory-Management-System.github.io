# frozen_string_literal: true

# This class is for Brands Controller
class BrandsController < ApplicationController
  before_action :logged_in_user, only: %i[index new create edit update destroy show]
  before_action :brand_by_id, only: %i[edit update show]
  before_action :admin_user, only: %i[edit update new create destroy]

  def new
    @brand = Brand.new
  end

  def create
    @brand = Brand.new(brand_params)
    if @brand.save
      redirect_to brands_path, notice: 'Brand created successfully.'
    else
      render :new, status: :unprocessable_entity
    end
  end

  def index
    @brands = Brand.ordered_by_name
  end

  def edit; end

  def update
    if @brand.update(brand_params)
      redirect_to params[:previous_request], notice: 'Brand updated successfully.'
    else
      render :edit, status: :unprocessable_entity
    end
  end

  def show; end

  def destroy
    Brand.find(params[:id]).destroy
    redirect_to brands_path
    flash[:warning] = 'Brand deleted successfully.'
  end

  private

  def brand_params
    params.require(:brand).permit(:name, :manufacturer, :manufacturer_email, :manufacturer_office)
  end

  def brand_by_id
    @brand = Brand.find(params[:id])
  end
end
