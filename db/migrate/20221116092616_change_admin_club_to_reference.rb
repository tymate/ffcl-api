class ChangeAdminClubToReference < ActiveRecord::Migration[7.0]
  def change

    remove_column :clubs, :club_admin, :string
    add_reference :clubs, :admin, class_name: "Users", index: true
  end
end
