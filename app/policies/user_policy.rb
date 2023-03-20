# frozen_string_literal: true

class UserPolicy < ApplicationPolicy
  def show?
    user == record
  end

  def join_club?
    true
  end

  def quit_club?
    record.users.include?(user)
  end

  alias_rule :update?, to: :show
  alias_rule :quit_session?, to: :quit_club?
end
