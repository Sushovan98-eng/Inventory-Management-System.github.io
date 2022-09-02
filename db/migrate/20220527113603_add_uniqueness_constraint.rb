# frozen_string_literal: true

class AddUniquenessConstraint < ActiveRecord::Migration[7.0]
  def change
    add_index :brands, :name, unique: { case_sensitive: false }
    add_index :categories, :name, unique: { case_sensitive: false }
    add_index :items, :name, unique: { case_sensitive: false }
    add_index :users, :mobile_no, unique: true
  end
end
