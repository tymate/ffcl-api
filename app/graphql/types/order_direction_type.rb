# frozen_string_literal: true

module Types
  class OrderDirectionType < Types::BaseEnum
    description 'Ordering direction values'

    graphql_name 'OrderDirection'

    value 'ASC', value: :asc
    value 'DESC', value: :desc
  end
end
