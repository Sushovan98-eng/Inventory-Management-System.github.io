# frozen_string_literal: true

# Removing quantity from items table
class RemoveQuantityFromItems < ActiveRecord::Migration[7.0]
  def change
    remove_column :items, :quantity, :string
  end
end
