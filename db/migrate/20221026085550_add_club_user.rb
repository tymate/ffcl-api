class AddClubUser < ActiveRecord::Migration[7.0]
  def change
    create_table :club_users do |t|
      t.references :user, null: false, foreign_key: true
      t.references :club, null: false, foreign_key: true
      t.boolean :admin, default: false

      t.timestamps
    end
  end
end
