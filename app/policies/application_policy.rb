class ApplicationPolicy < ActionPolicy::Base
  authorize :doorkeeper_token
  authorize :user

  pre_check :authenticated?

  def authenticated?
    deny! if doorkeeper_token.nil?
  end

  def index?
    true
  end
  # Configure additional authorization contexts here
  # (`user` is added by default).
  #
  #   authorize :account, optional: true
  #
  # Read more about authorization context: https://actionpolicy.evilmartians.io/#/authorization_context
end
