class AddNewStockToItem < ActiveRecord::Migration[7.0]
  def change
    add_column :items, :new_stock, :integer
  end
end
