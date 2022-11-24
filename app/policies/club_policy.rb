# frozen_string_literal: true

class ClubPolicy < ApplicationPolicy
  def show?
    true
  end

  def create?
    true
  end

  def create_session?
    record.admin == user
  end

  alias invitation? create_session?
end
