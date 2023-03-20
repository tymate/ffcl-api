# frozen_string_literal: true

module Types
  class ReviewType < Types::BaseType
    description 'A review'

    field :id, ID, null: false
    field :rating, Integer, null: false
    field :comment, String, null: true
    field :reading_session, Types::ReadingSessionType, null: false
    field :user, Types::UserType, null: true
    field :book, Types::BookType, null: true
  end
end
