class CategoriesController < ApplicationController
  before_action :logged_in_user, only: [:index, :new, :create, :edit, :update, :destroy,:show]
  before_action :get_category_by_id, only: [:edit, :show, :update]
  #before_action :admin_user, only: [:new, :create, :edit, :update, :destroy]
  
    def index
      @categories = Category.all
    end
  
    def new
      @category = Category.new
    end
  
    def create
      @category = Category.new(category_params)
      if @category.save
        redirect_to categories_path, notice: "Category created successfully." 
      else
        render :new, status: :unprocessable_entity
      end
    end
  
    def edit 
    end
  
    def show
    end
  
    def update
      if @category.update(category_params)
        redirect_to categories_path, notice: "Category updated successfully."
      else
        render :edit, status: :unprocessable_entity
      end
    end
  
    def destroy
      Category.find(params[:id]).destroy
      redirect_to categories_url
      flash[:warning] = "Category deleted."
    end
  
    private
      def category_params
        params.require(:category).permit(:name, :description)
      end
      
      def get_category_by_id
        @category = Category.find(params[:id])
      end
      
  end