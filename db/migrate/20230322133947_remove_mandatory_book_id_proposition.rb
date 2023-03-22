class RemoveMandatoryBookIdProposition < ActiveRecord::Migration[7.0]
  def change
    change_column_null :propositions, :book_id, true
  end
end
