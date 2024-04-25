ActiveAdmin.register Game do
  index do
    selectable_column
    id_column
    column "Image" do |id|
      image_tag(
        "https://store.playstation.com/store/api/chihiro/00_09_000/container/TR/tr/99/#{id.nps_id}/0/image?w=346&h=346",
        height: '30')
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
