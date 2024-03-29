# frozen_string_literal: true

# Create issues table
class CreateIssues < ActiveRecord::Migration[7.0]
  def change
    create_table :issues do |t|
      t.references :user, foreign_key: true
      t.references :item, foreign_key: true
      t.text :issue_description
      t.datetime :solved_at
      t.text :feedback

      t.timestamps
    end
  end
end
