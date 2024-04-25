ActiveAdmin.register Order do
  index do
    selectable_column
    id_column
    column "User" do |order|
      order.user.full_name if order.user
    end
    column :status
    column :address
    column :comments
    actions
  end

  filter :user_id
  filter :status
end
