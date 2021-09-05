class CreateUserGenreRelations < ActiveRecord::Migration[6.0]
  def change
    create_table :user_genre_relations do |t|
      t.references :user, foreign_key: true
      t.references :genre, foreign_key: true
      t.timestamps
    end
    add_index :user_genre_relations, [:user_id, :genre_id], unique: true
  end
end
