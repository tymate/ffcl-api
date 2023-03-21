# frozen_string_literal: true

class ReadingSessionPolicy < ApplicationPolicy
  def show?
    record.club.users.include?(user)
  end

  def submit_book?
    return false unless record.club.users.include?(user)
    return false if user.propositions.include?(record)

    record.state == 'submission'
  end

  def create_review?
    true if record.state == 'reading'
  end

  def join?
    # record.users.exclude?(user) && record.state == 'submission'
    true
  end

  def quit?
    record.users.include?(user)
  end

  def destroy?
    record.users.include?(user)
  end
end
