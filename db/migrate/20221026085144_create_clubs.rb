class CreateClubs < ActiveRecord::Migration[7.0]
  def change
    create_table :clubs do |t|
      t.string :label
      t.string :description
      t.string :club_admin
      t.integer :invitation_code

      t.timestamps
    end
  end
end
