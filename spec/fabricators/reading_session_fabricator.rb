Fabricator(:reading_session) do
  club
  name                { Faker::Lorem.sentence }
  next_step_date      nil
  read_due_date       nil
  submission_due_date nil
end

# == Schema Information
#
# Table name: reading_sessions
#
#  id                  :bigint           not null, primary key
#  name                :string           not null
#  next_step_date      :datetime
#  read_due_date       :datetime
#  state               :string           default("submission"), not null
#  submission_due_date :datetime
#  created_at          :datetime         not null
#  updated_at          :datetime         not null
#  club_id             :bigint           not null
#
# Indexes
#
#  index_reading_sessions_on_club_id  (club_id)
#
# Foreign Keys
#
#  fk_rails_...  (club_id => clubs.id)
#
