# frozen_string_literal: true

class ConcludeReadingSessionJob < ApplicationJob
  queue_as :default

  def perform(session_id)
    reading_session = ReadingSession.find(session_id)
    reading_session.conclude!
  end
end
