# frozen_string_literal: true

module Mutations
  class SubmitBook < BaseMutation
    description 'Allow to submit a book'

    argument :google_book_id, String, required: true
    argument :reading_session_id, ID, required: true, loads: Types::ReadingSessionType

    field :proposition, Types::PropositionType, null: true

    def resolve(reading_session:, google_book_id:)
      authorize! reading_session, to: :submit_book?

      book = create_book(google_book_id)
      proposition = reading_session.propositions.create!(user: current_user, book:)

      { proposition: }
    end

    private

    def create_book(google_book_id)
      Book.create_with(book_params(google_book_id))
          .find_or_create_by(google_book_id:)
    end

    def book_params(google_book_id)
      response = ::GoogleBookApiClient.get_book(google_book_id)
      json = JSON.parse(response.body)

      authors = json.dig('volumeInfo', 'authors').map do |name|
        Author.find_or_create_by(name:)
      end

      {
        title: json['volumeInfo']['title'],
        description: json['volumeInfo']['description'],
        isbn: json.dig('volumeInfo', 'industryIdentifiers', 1, 'identifier'),
        authors:
      }
    end
  end
end
