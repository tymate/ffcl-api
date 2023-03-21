# frozen_string_literal: true

class UserPolicy < ApplicationPolicy
  def show?
    user == record
  end

  alias_rule :update?, to: :show
  alias_rule :quit_session?, to: :quit_club?
end
