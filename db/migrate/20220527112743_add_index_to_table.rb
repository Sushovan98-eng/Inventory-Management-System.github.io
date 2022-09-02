# frozen_string_literal: true

class AddIndexToTable < ActiveRecord::Migration[7.0]
  def change
    add_index :users, :email, unique: true
  end
end
