class BrandsController < ApplicationController

  before_action :logged_in_user, only: [:index, :new, :create, :edit, :update, :destroy,:show]
  before_action :get_brand_by_id, only: [:edit, :update, :show]
  #before_action :admin_user, only: [:edit, :update, :new, :create, :destroy]




  def new
    @brand = Brand.new
  end

  def create
    @brand = Brand.new(brand_params)
    if @brand.save
      redirect_to brands_path, notice: "Brand created successfully."
    else
      render :new, status: :unprocessable_entity
    end
  end

  def index
    @brands = Brand.all
  end
  

  def edit
  end

  def update
    if @brand.update(brand_params)
      redirect_to params[:previous_request], notice: "Brand updated successfully."
    else
      render :edit, status: :unprocessable_entity
    end    
  end


  def show
  end

  def destroy
    Brand.find(params[:id]).destroy
    redirect_to brands_path
    flash[:warning] = "Brand deleted successfully."
  end


  private

    def brand_params
      params.require(:brand).permit(:name, :manufacturer, :manufacturer_email, :manufacturer_office)
    end

    def get_brand_by_id
      @brand = Brand.find(params[:id])
    end

end
