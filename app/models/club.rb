# frozen_string_literal: true

class Club < ApplicationRecord
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
