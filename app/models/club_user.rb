# frozen_string_literal: true

class ClubUser < ApplicationRecord
  belongs_to :club
  belongs_to :user
end

# == Schema Information
#
# Table name: club_users
#
#  id         :bigint           not null, primary key
#  admin      :boolean          default(FALSE)
#  created_at :datetime         not null
#  updated_at :datetime         not null
#  club_id    :bigint           not null
#  user_id    :bigint           not null
#
# Indexes
#
#  index_club_users_on_club_id  (club_id)
#  index_club_users_on_user_id  (user_id)
#
# Foreign Keys
#
#  fk_rails_...  (club_id => clubs.id)
#  fk_rails_...  (user_id => users.id)
#
