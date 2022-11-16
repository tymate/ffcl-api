class AddSelectedBookToReadingSession < ActiveRecord::Migration[7.0]
  def change
    add_reference :reading_sessions, :selected_book, null: true, foreign_key: { to_table: :books }
  end
end
