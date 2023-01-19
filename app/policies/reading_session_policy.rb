# frozen_string_literal: true

class ReadingSessionPolicy < ApplicationPolicy
  def submit_book?
    return false unless record.club.users.include?(user)
    return false if user.propositions.include?(record)

    record.state == 'submission'
  end
end