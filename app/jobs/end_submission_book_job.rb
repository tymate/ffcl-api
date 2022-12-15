# frozen_string_literal: true

class EndSubmissionBookJob < ApplicationJob
  queue_as :default

  def perform(session_id)
    reading_session = ReadingSession.find(session_id)
    reading_session.start_draw!
  end
end
