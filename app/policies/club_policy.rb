# frozen_string_literal: true

class ClubPolicy < ApplicationPolicy
  def show?
    true
  end

  alias create? show?

  def create_session?
    return false unless record.admin == user

    record.reading_sessions.where(state: %w[submission draw reading]).empty?
  end

  def join?
    record.users.exclude?(user)
  end

  def quit?
    record.users.include?(user)
  end

  # relation_scope(&:all)

  alias_rule :destroy?, :update?, :invitation?, to: :create_session?
end
