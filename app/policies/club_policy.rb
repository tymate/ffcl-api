# frozen_string_literal: true

class ClubPolicy < ApplicationPolicy
  def show?
    user.present?
  end

  alias create? show?

  def update?
    record.admin == user
  end
end
