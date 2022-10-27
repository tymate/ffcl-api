# frozen_string_literal: true

class ClubPolicy < ApplicationPolicy
  def show?
    true
  end

  def create?
    true
  end

  def join?
    true
  end
end
