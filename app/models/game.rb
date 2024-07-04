class Game < ApplicationRecord
  has_many :order_items, foreign_key: :product_id
  has_many :favorites, dependent: :destroy
  has_one_attached :image do |attachable|
    attachable.variant :thumb, resize_to_limit: [100, 100]
    attachable.variant :medium, resize_to_limit: [346, 346]
    attachable.variant :large, resize_to_limit: [636, 636]
  end

  def self.ransackable_attributes(auth_object = nil)
    %w[id content name ps_id price old_price bonus_price img platform created_at
       md5_hash deleted run_id touched_run_id genre rus_voice rus_screen nps_id]
  end

  def self.ransackable_associations(auth_object = nil)
    %w[]
  end
end
