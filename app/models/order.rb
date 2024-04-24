class Order < ApplicationRecord
  belongs_to :user
  has_many :order_items, dependent: :destroy
  attribute :privacy, :boolean, default: false
  validates :privacy, acceptance: { message: 'Необходимо дать согласие на обработку персональных данных!' }
  validates :address, presence: true
end