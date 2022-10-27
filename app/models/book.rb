# frozen_string_literal: true

class Book < ApplicationRecord
  has_many :propositions, dependent: :destroy, inverse_of: :book

  validates :title, :isbn, presence: true
end

# == Schema Information
#
# Table name: books
#
#  id                  :bigint           not null, primary key
#  category            :string
#  date_of_publication :date
#  description         :text
#  isbn                :string           not null
#  title               :string           not null
#  created_at          :datetime         not null
#  updated_at          :datetime         not null
#
