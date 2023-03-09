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
    email: 'kevin.j@tymate.com',
    username: 'mj',
    password: 'password'
  ).find_or_create_by(email: 'kevin.j@tymate.com')

  Club.create_with(
    description: 'Club 1 description',
    admin: User.first,
    invitation_code: '123456'
  ).find_or_create_by(label: 'Club 1')

  ClubUser.create_with(
    admin: User.first
  ).find_or_create_by(user: User.first, club: Club.first)

  ReadingSession.create_with(
    club: Club.first,
    name: 'Reading Session 1',
    submission_due_date: 10.days.from_now,
    read_due_date: 1.month.from_now
  ).find_or_create_by(state: 'submission')

  Book.create_with(
    title: 'Book 1',
    isbn: '978-3-16-148410-0'
  ).find_or_create_by(google_book_id: '1')

  Review.create_with(
    user: User.first,
    book: Book.first,
    rating: 5,
    comment: 'This is a comment'
  ).find_or_create_by(reading_session: ReadingSession.first)

end
