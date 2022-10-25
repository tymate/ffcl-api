# frozen_string_literal: true

# This file should contain all the record creation needed to seed the database with its default values.
# The data can then be loaded with the bin/rails db:seed command (or created alongside the database with db:setup).
#
# Examples:
#
#   movies = Movie.create([{ name: "Star Wars" }, { name: "Lord of the Rings" }])
#   Character.create(name: "Luke", movie: movies.first)

if Rails.env.development?
  Doorkeeper::Application.find_or_create_by!(
    name: 'ffcl-app',
    uid: 'bebe4950-57cb-4225-ac9a-dc0448b430fa',
    redirect_uri: 'https://heidenreich-hammes.co/asa_dooley',
    confidential: false
  )

  User.create_with(
    email: 'maxim.j@tymate.com',
    username: 'mj',
    password: 'x'
  ).find_or_create_by(email: 'maxim.j@tymate.com')
end
