class ItemsController < ApplicationController
    include ApplicationHelper
    before_action :logged_in_user, only: [:index, :new, :create, :edit, :update, :show, :destroy]
    before_action :get_item_by_id, only: [:edit, :update, :show]
    before_action :admin_user, only: [:destroy, :new, :create, :edit, :update]


    def index
        @items = Item.all
    end

    def new
        @item = Item.new
    end

    def create
        item_data = item_params.merge(in_stock: item_params[:total_stock])
        @item = Item.new(item_data)
        if @item.save
            redirect_to items_path, notice: "Item created successfully."
        else
            render :new
        end
    end

    def edit
    end

    def show
        @brand_name = @item.brand_id.nil? ? "<--Null-->" : Brand.find(@item.brand_id).name
        @category_name = @item.category_id.nil? ? "<--Null-->" : Category.find(@item.category_id).name
    end

    def update
        previous_quantity = @item.total_stock
        if((item_params[:total_stock].to_i - previous_quantity + @item.in_stock) < 0)
            redirect_to edit_item_path(@item), warning: "Currently more items are alloted than entered values."
        elsif @item.update(item_params)
            redirect_to items_path
            flash[:warning] = "Item updated successfully."
            @item.in_stock += (@item.total_stock - previous_quantity)
        else
            render :edit
        end
    end

    def destroy
        Item.find(params[:id]).destroy
        redirect_to items_path
        flash[:warning] =  "Item has been deleted."
    end

    def allotments
        @allotments = Allotment.where(item_id: [params[:id]])
    end

    private

    def item_params
        params.require(:item).permit(:name, :category_id, :brand_id, :price, :quantity, :price, :total_stock, :minimum_required_stock)
    end

    def get_item_by_id
        @item = Item.find(params[:id])
      end
end
