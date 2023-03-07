# frozen_string_literal: true

Fabricator(:review) do
  rating { rand(0..5) }
  comment { Faker::Lorem.sentence }
  reading_session
  user
  book
end