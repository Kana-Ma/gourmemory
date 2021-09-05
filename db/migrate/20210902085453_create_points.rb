class CreatePoints < ActiveRecord::Migration[6.0]
  def change
    create_table :points do |t|
      t.string :point1, null: false
      t.string :point2, null: false
      t.string :point3, null: false
      t.text :explanation, null: false
      t.references :user, null: false, foreign_key: true
      t.references :genre, null: false, foreign_key: true
      t.timestamps
    end
  end
end
