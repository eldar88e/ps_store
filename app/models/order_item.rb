class OrderItem < ApplicationRecord
  belongs_to :order
  belongs_to :game, foreign_key: :product_id
  validates :quantity, presence: true, numericality: { only_integer: true, greater_than: 0 }
  validates :unit_price, presence: true, numericality: { greater_than_or_equal_to: 0 }
end