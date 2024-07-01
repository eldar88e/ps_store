ActiveAdmin.register Game do
  index do
    selectable_column
    id_column
    column "Image" do |game|
      image_tag(storage_img(game, :thumb), style: 'height: 30px')
    end
    column :name
    column :nps_id
    column :price
    column :old_price
    column :genre
    column :rus_voice
    column :rus_screen
    actions
  end

  filter :name
  filter :nps_id
  filter :price
  filter :old_price
  filter :genre
end
