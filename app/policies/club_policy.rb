# frozen_string_literal: true

class ClubPolicy < ApplicationPolicy
  def show?
    user.present?
  end

  alias create? show?

  def create_session?
    record.admin == user
  end

  alias_rule :destroy?, :update?, to: :create_session?
end
