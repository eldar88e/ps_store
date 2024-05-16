class Game < ApplicationRecord
  has_many :order_items, foreign_key: :product_id
  has_many :favorites, dependent: :destroy

  def self.ransackable_attributes(auth_object = nil)
    %w[id content name ps_id price old_price bonus_price img platform created_at
       md5_hash deleted run_id touched_run_id genre rus_voice rus_screen nps_id]
  end

  def self.ransackable_associations(auth_object = nil)
    %w[]
  end
end
