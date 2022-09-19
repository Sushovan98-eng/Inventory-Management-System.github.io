# frozen_string_literal: true

# Adding mobile number to users table
class AddMobToUser < ActiveRecord::Migration[7.0]
  def change
    add_column :users, :mobile_no, :string, limit: 10
  end
end
