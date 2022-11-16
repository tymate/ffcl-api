class CreateBooks < ActiveRecord::Migration[7.0]
  def change
    create_table :books do |t|
      t.string :title, null: false
      t.text :description
      t.string :category
      t.string :isbn, null: false
      t.date :date_of_publication

      t.timestamps
    end
  end
end
