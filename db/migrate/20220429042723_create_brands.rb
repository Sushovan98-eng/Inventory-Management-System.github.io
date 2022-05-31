class CreateBrands < ActiveRecord::Migration[7.0]
  def change
    create_table :brands do |t|
      t.string :name, uniqueness: {case_sensitive: false}
      t.string :manufacturer
      t.string :manufacturer_email
      t.string :manufacturer_office

      t.timestamps
    end
  end
end
