# frozen_string_literal: true

require 'rails_helper'

RSpec.describe Book do
  pending "add some examples to (or delete) #{__FILE__}"
end

# == Schema Information
#
# Table name: books
#
#  id                  :bigint           not null, primary key
#  category            :string
#  date_of_publication :date
#  description         :text
#  isbn                :string           not null
#  title               :string           not null
#  created_at          :datetime         not null
#  updated_at          :datetime         not null
#
