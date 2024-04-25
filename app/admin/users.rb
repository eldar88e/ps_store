ActiveAdmin.register User do
  index do
    selectable_column
    id_column
    column "Avatar" do |id|
      image_tag(id.avatar_url, height: '30') if id.avatar_url
    end
    column :email
    column :full_name
    column :provider
    actions
  end

  filter :user_id
  filter :status
end
