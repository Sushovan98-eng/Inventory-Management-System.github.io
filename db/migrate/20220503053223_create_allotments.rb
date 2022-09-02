# frozen_string_literal: true

class CreateAllotments < ActiveRecord::Migration[7.0]
  def change
    create_table :allotments do |t|
      t.references :user, foreign_key: true
      t.references :item, foreign_key: true
      t.integer :allotment_quantity
      t.datetime :dealloted_at

      t.timestamps
    end
  end
end
