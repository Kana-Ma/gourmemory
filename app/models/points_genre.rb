class PointsGenre
  include ActiveModel::Model
  attr_accessor :genre_name, :point1, :point2, :point3, :explanation, :user_id

  with_options presence: true do
    validates :genre_name
    validates :point1
    validates :point2
    validates :point3
    validates :explanation
    validates :user_id
  end

  validate :validate_point

  def save
    genre = Genre.where(genre_name: genre_name).first_or_initialize
    genre.save
    Point.create(point1: point1, point2: point2, point3: point3, explanation: explanation, user_id: user_id, genre_id: genre.id)
    UserGenreRelation.create(user_id: user_id, genre_id: genre.id)
  end

  private

  def validate_point
    genre = Genre.where(genre_name: genre_name).first_or_initialize
    genre.save
    point = Point.new(point1: point1, point2: point2, point3: point3, explanation: explanation, user_id: user_id, genre_id: genre.id)
    return if point.valid?
    point.errors.each do |attr, error|
      errors.add(attr, error)
    end
  end
end