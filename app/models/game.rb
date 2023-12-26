class Game < ApplicationRecord
  def self.ransackable_attributes(auth_object = nil)
    %w[content name ps_id price old_price bonus_price img platform md5_hash deleted run_id touched_run_id genre rus_voice rus_screen]
  end

  def self.ransackable_associations(auth_object = nil)
    []
  end
end
