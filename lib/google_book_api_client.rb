# frozen_string_literal: true

require 'rest-client'

class GoogleBookApiClient
  API_URL = 'https://www.googleapis.com/books/v1/volumes/'

  def self.get_book(id)
    RestClient.get(API_URL + id)
  end
end
