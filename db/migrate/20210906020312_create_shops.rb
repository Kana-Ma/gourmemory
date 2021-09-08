class CreateShops < ActiveRecord::Migration[6.0]
  def change
    create_table :shops do |t|
      t.string :shop_name, null: false
      t.string :address, null: false
      t.float :total_rate, null: false, default: 0
      t.float :rate1, null: false, default: 0
      t.float :rate2, null: false, default: 0
      t.float :rate3, null: false, default: 0
      t.text :text, null: false
      t.references :user, null: false, foreign_key: true
      t.references :genre, null: false, foreign_key: true
      t.references :point, null: false, foreign_key: true
      t.timestamps
    end
  end
end
