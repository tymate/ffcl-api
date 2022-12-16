class AddGoogleBookIdToBooks < ActiveRecord::Migration[7.0]
  def change
    add_column :books, :google_book_id, :string, null: false
  end
end
