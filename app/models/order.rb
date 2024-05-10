class Order < ApplicationRecord
  belongs_to :user
  has_many :order_items, dependent: :destroy
  attribute :privacy, :boolean, default: false
  validates :privacy, presence: true
  validates :address, presence: true

  def self.ransackable_attributes(auth_object = nil)
    %w[address comments created_at id id_value status total_amount updated_at user_id]
  end

  def self.ransackable_associations(auth_object = nil)
    %w[order_items]
  end
end