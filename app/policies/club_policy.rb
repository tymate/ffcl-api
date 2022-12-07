# frozen_string_literal: true

class ClubPolicy < ApplicationPolicy
  def create?
    user.present?
  end

  alias show? create?

  def create_session?
    record.admin == user
  end

  alias destroy? create_session?
end
