# frozen_string_literal: true

module Types
  class BaseConnection < GraphQL::Types::Relay::BaseConnection
    include CurrentUserContext

    field :total_count, Integer, null: false

    def total_count
      return @total_count if @total_count.present?

      skipped = object.items.offset_value || 0
      @total_count = object.items.size + skipped
    end
  end
end
