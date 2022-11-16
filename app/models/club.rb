# frozen_string_literal: true

class Club < ApplicationRecord
  has_many :reading_sessions, dependent: :destroy, inverse_of: :club
  has_many :club_users, dependent: :destroy
  has_many :users, through: :club_users

  belongs_to :admin, class_name: 'User', optional: true
end

# == Schema Information
#
# Table name: clubs
#
#  id              :bigint           not null, primary key
#  description     :string
#  invitation_code :string(6)
#  label           :string
#  created_at      :datetime         not null
#  updated_at      :datetime         not null
#  admin_id        :bigint
#
# Indexes
#
#  index_clubs_on_admin_id  (admin_id)
#
