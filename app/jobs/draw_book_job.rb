# frozen_string_literal: true

class DrawBookJob < ApplicationJob
  queue_as :default

  def perform(session_id)
    reading_session = ReadingSession.find(session_id)

    selected_book = reading_session.books.sample # TO DO implement a more complex algorythm for the draw
    reading_session.update(selected_book:)

    reading_session.club.previous_reading_session&.archive
    reading_session.start_reading!
  end
end
