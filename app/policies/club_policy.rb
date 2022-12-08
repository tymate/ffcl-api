# frozen_string_literal: true

class ClubPolicy < ApplicationPolicy
  def show?
    true
  end

  alias create? show?

  def create_session?
    record.admin == user
  end

  relation_scope(&:all)

  alias_rule :destroy?, :update?, :invitation?, to: :create_session?
end
