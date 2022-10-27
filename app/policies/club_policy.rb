# frozen_string_literal: true

class ClubPolicy < ApplicationPolicy
  def show?
    authenticated?
  end

  def create?
    true
  end
end
