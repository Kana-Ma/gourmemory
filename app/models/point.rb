class Point < ApplicationRecord
  belongs_to :user
  belongs_to :genre
  has_many :shops

  validates :genre_id, uniqueness: { scope: :user_id }
end
