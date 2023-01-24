# frozen_string_literal: true

class UserPolicy < ApplicationPolicy
  def show?
    user == record
  end

  def update?
    user == record
  end

  def join_club?
    true
  end

  def quit_club?
    user == record
  end
end
