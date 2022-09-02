# frozen_string_literal: true

class RemoveQuantityFromItems < ActiveRecord::Migration[7.0]
  def change
    remove_column :items, :quantity, :string
  end
end
