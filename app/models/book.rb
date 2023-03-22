# frozen_string_literal: true

class Book < ApplicationRecord
  has_many :propositions, dependent: :destroy, inverse_of: :books
  has_many :reading_sessions, dependent: :destroy, foreign_key: :selected_book_id, inverse_of: :books
  has_many :author_books, dependent: :destroy
  has_many :authors, through: :author_books
  has_many :reviews, dependent: :destroy

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
#  google_book_id      :string           not null
#
