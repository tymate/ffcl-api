# frozen_string_literal: true

Fabricator(:user) do
  email { Faker::Internet.email }
  password { Faker::Internet.password }
end
