# frozen_string_literal: true

class Item < ApplicationRecord
  belongs_to :category
  belongs_to :brand
  has_many :allotments, dependent: :destroy
  has_many :issues, dependent: :destroy
  validates :name, presence: true, uniqueness: { case_sensitive: false }
  attribute :in_stock, default: 0
  attribute :total_stock, default: 0
  attribute :new_stock, default: 0
  attribute :minimum_required_stock, default: 0

  default_scope { order(name: :asc) }

  def item_display_name
    @brand_name = brand_id.nil? ? '<Brand N/A>' : Brand.find(brand_id).name
    "Brand:#{@brand_name} Name:#{name} Currently in stock : #{in_stock}"
  end
end
