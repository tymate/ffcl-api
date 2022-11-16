# frozen_string_literal: true

Fabricator(:book) do
  title               'MyString'
  description         'MyText'
  category            'MyString'
  isbn                'MyString'
  date_of_publication '2022-10-27'
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
