class Order < ApplicationRecord
  belongs_to :client
  has_many :order_items
end