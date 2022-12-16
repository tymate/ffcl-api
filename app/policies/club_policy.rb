# frozen_string_literal: true

class ClubPolicy < ApplicationPolicy
  def show?
    true
  end

  alias create? show?

  def create_session?
    # to do : check if a session already exists with state submission, draw, reading
    # if so return error
    record.admin == user
  end

  # relation_scope(&:all)

  alias_rule :destroy?, :update?, :invitation?, to: :create_session?
end
