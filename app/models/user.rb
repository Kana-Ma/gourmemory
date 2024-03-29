class User < ApplicationRecord
  # Include default devise modules. Others available are:
  # :confirmable, :lockable, :timeoutable, :trackable and :omniauthable
  devise :database_authenticatable, :registerable,
         :recoverable, :rememberable, :validatable

  validates :prefecture_id, numericality: { other_than: 1, message: :select_prefecture }
  validates :nickname, presence: true, length: { maximum: 10 }

  PASSWORD_REGEX = /\A(?=.*?[a-z])(?=.*?[\d])[a-z\d]+\z/i.freeze
  validates_format_of :password, with: PASSWORD_REGEX, message: :invalid_password

  extend ActiveHash::Associations::ActiveRecordExtensions
  belongs_to :prefecture

  has_many :user_genre_relations
  has_many :genres, through: :user_genre_relations
  has_many :points
  has_many :shops
  has_many :comments
end
