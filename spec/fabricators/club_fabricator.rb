# frozen_string_literal: true

Fabricator(:club) do
  label           { Faker::Lorem.words(number: 1) }
  description     { Faker::Lorem.paragraph }
  invitation_code { Faker::Number.number(digits: 6) }
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
