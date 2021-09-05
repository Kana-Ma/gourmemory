class Genre < ApplicationRecord
  has_many :user_genre_relations
  has_many :users, through: :user_genre_relations

  validates :genre_name, uniqueness: true, presence: true
end
