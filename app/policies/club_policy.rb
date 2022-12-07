# frozen_string_literal: true

class ClubPolicy < ApplicationPolicy
  def show?
    user.present?
  end

  alias create? show?

  def create_session?
    record.admin == user
  end

  alias destroy?, update?, create_session?
end
