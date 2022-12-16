# frozen_string_literal: true

require 'rails_helper'

RSpec.describe Types::MutationType, type: :request do
  let(:json) { JSON.parse(response.body) }
  let(:query) { 'submitBook' }
  let(:club) { Fabricate(:club) }
  let(:reading_session) { Fabricate(:reading_session, club:) }
  let(:google_book_id) { '12345' }
  let(:variables) do
    {
      input: {
        readingSessionId: id_from_object(reading_session),
        googleBookId: google_book_id
      }
    }
  end

  it_behaves_like 'with standard user' do
    before do
      stub_request(:get, "https://www.googleapis.com/books/v1/volumes/#{google_book_id}")
        .to_return(
          status: 200,
          body: {
            'kind' => 'books#volume',
            'id' => google_book_id.to_s,
            'etag' => 'IqO+HNzTo5Q',
            'volumeInfo' =>
                {
                  'title' => "L'histoire de Teddy",
                  'authors' => ['Théodore LeCaillou'],
                  'publisher' => 'Gallimard',
                  'publishedDate' => '1993',
                  'industryIdentifiers' =>
                  [{ 'type' => 'ISBN_10',
                     'identifier' => '2070733467' },
                   { 'type' => 'ISBN_13',
                     'identifier' => '9782070733460' }]
                }
          }.to_json
        )
    end

    context 'when user is club member' do
      before do
        club.users << user
      end

      it 'allows user to join session and submit a book' do
        do_graphql_request

        expect(json.dig('data', 'submitBook', 'proposition', 'user', 'id')).to eq(id_from_object(user))
        expect(json.dig('data', 'submitBook', 'proposition', 'book', 'googleBookId')).to eq(google_book_id)
      end
    end

    context 'when user does not enter a google book id' do
      let(:google_book_id) { nil }

      it 'does not allow user to join reading_sepssion' do
        do_graphql_request

        expect(json.dig('errors', 0, 'message')).to be_present
      end
    end

    context 'when user is not club member' do
      it 'does not allow user to join reading_session' do
        do_graphql_request

        expect(json.dig('errors', 0, 'extensions', 'code')).to eq('forbidden')
      end
    end
  end

  describe 'when unauthenticated' do
    before do
      do_graphql_request
    end

    include_examples 'when unauthenticated'
  end
end
