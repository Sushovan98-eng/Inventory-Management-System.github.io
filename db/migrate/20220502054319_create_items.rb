# frozen_string_literal: true

class CreateItems < ActiveRecord::Migration[7.0]
  def change
    create_table :items do |t|
      t.string :name, uniqueness: { case_sensitive: false }
      t.references :brand, foreign_key: true
      t.references :category, foreign_key: true
      t.integer :in_stock
      t.decimal :price
      t.integer :minimum_required_stock
      t.string :quantity
      t.integer :total_stock

      t.timestamps
    end
  end
end
