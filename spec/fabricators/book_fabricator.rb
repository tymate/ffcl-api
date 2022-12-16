# frozen_string_literal: true

Fabricator(:book) do
  title               { Faker::Book.title }
  description         { Faker::Books::Lovecraft.paragraphs(number: 2) }
  category            { Faker::Book.genre }
  isbn                { Faker::Number.number(digits: 10) }
  date_of_publication { Faker::Date.in_date_period }
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
