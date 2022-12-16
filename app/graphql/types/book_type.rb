# frozen_string_literal: true

module Types
  class BookType < Types::BaseType
    description 'A book'

    field :id, ID, null: false
    field :title, String, null: false
    field :description, String, null: true
    field :category, String, null: true
    field :date_of_publication, GraphQL::Types::ISO8601DateTime, null: true
    field :isbn, String, null: false
    field :google_book_id, String, null: false
  end
end
