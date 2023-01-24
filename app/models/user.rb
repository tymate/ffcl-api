# frozen_string_literal: true

class User < ApplicationRecord
  include Clearance::User

  has_many :propositions, dependent: :destroy, inverse_of: :user
  has_many :club_users, dependent: :destroy
  has_many :clubs, through: :club_users
  has_many :reading_sessions, through: :clubs

  validates :email, :username, presence: true
end

# == Schema Information
#
# Table name: users
#
#  id                 :bigint           not null, primary key
#  confirmation_token :string(128)
#  email              :string           not null
#  encrypted_password :string(128)      not null
#  remember_token     :string(128)      not null
#  username           :string           not null
#  created_at         :datetime         not null
#  updated_at         :datetime         not null
#
# Indexes
#
#  index_users_on_confirmation_token  (confirmation_token) UNIQUE
#  index_users_on_email               (email)
#  index_users_on_remember_token      (remember_token) UNIQUE
#
