class CreateReadingSessions < ActiveRecord::Migration[7.0]
  def change
    create_table :reading_sessions do |t|
      t.references :club, null: false, foreign_key: true
      t.string :name, null: false
      t.string :state, null: false, default: 'submission'
      t.datetime :next_step_date
      t.datetime :read_due_date
      t.datetime :submission_due_date

      t.timestamps
    end
  end
end
