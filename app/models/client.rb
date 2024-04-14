class Client < ApplicationRecord
  has_many :orders
  validates :email, uniqueness: true
  validates :phone, presence: true, presence: true

  validates :phone, format: { with: /\A[0-9\+\-\(\)]{10,}\z/, message: "должен содержать только цифры, плюсы, минусы, скобки и быть длиной не менее 10 символов" }
end
