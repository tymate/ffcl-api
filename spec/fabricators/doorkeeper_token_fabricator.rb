# frozen_string_literal: true

Fabricator(:token, class_name: 'Doorkeeper::AccessToken') do
  transient :user, :application
  application_id { |attrs| attrs[:application] ? attrs[:application].id : Fabricate(:application).id }
  resource_owner_id { |attrs| attrs[:user] ? attrs[:user].id : Fabricate(:user).id }
end
