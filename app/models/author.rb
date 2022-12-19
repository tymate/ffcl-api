# frozen_string_literal: true

class Author < ApplicationRecord
  has_many :author_books, dependent: :destroy
  has_many :books, through: :author_books

  validates :name, presence: true
end

# == Schema Information
#
# Table name: authors
#
#  id         :bigint           not null, primary key
#  name       :string           not null
#  created_at :datetime         not null
#  updated_at :datetime         not null
#
