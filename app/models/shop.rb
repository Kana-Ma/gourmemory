class Shop < ApplicationRecord
  with_options presence: true do
    validates :shop_name
    validates :address
    validates :total_rate, numericality: { greater_than_or_equal_to: 0.5, less_than_or_equal_to: 5 }
    validates :rate1, numericality: { greater_than_or_equal_to: 0.5, less_than_or_equal_to: 5 }
    validates :rate2, numericality: { greater_than_or_equal_to: 0.5, less_than_or_equal_to: 5 }
    validates :rate3, numericality: { greater_than_or_equal_to: 0.5, less_than_or_equal_to: 5 }
    validates :text
  end

  belongs_to :user
  belongs_to :genre
  belongs_to :point
  has_one_attached :image

  geocoded_by :address
  after_validation :geocode, if: :address_changed?
end
