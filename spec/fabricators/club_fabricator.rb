# frozen_string_literal: true

Fabricator(:club) do
  label           { Faker::Lorem.words(2).join(' ') }
  description     { Faker::Lorem.paragraph }
  invitation_code { Faker::Lorem.characters(6) }
end

# == Schema Information
#
# Table name: clubs
#
#  id              :bigint           not null, primary key
#  club_admin      :string
#  description     :string
#  invitation_code :integer
#  label           :string
#  created_at      :datetime         not null
#  updated_at      :datetime         not null
#
