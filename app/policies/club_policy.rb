# frozen_string_literal: true

class ClubPolicy < ApplicationPolicy
  def show?
    true
  end

  def create?
    true
  end

  alias_rule :index, to: :show?

  def create_session?
    record.admin == user
  end

  relation_scope(&:all)
end
