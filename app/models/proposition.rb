# frozen_string_literal: true

class Proposition < ApplicationRecord
  belongs_to :reading_session
  belongs_to :user
  belongs_to :book
end

# == Schema Information
#
# Table name: propositions
#
#  id                 :bigint           not null, primary key
#  created_at         :datetime         not null
#  updated_at         :datetime         not null
#  book_id            :bigint           not null
#  reading_session_id :bigint           not null
#  user_id            :bigint           not null
#
# Indexes
#
#  index_propositions_on_book_id             (book_id)
#  index_propositions_on_reading_session_id  (reading_session_id)
#  index_propositions_on_user_id             (user_id)
#
# Foreign Keys
#
#  fk_rails_...  (book_id => books.id)
#  fk_rails_...  (reading_session_id => reading_sessions.id)
#  fk_rails_...  (user_id => users.id)
#
