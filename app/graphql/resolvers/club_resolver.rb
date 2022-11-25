# frozen_string_literal: true

module Resolvers
  class ClubResolver < BaseResolver
    include SearchObject.module(:graphql)

    description 'Search resolver for club'

    type Types::ClubType.connection_type, null: false

    scope do
      if object.is_a?(ApplicationRecord)
        authorized_scope(object.clubs)
      else
        authorized_scope(Club.all)
      end
    end

    class OrderColumnEnum < Types::BaseEnum
      description 'Available columns for ordering'

      graphql_name 'ClubOrderColumn'
      value 'CREATED_AT', value: :created_at
      value 'UPDATED_AT', value: :updated_at
    end

    class ClubOrderCriteria < Types::BaseInputObject
      description 'Criteria for ordering'

      argument :column, OrderColumnEnum, required: true
      argument :direction, Types::OrderDirectionType, required: true
    end

    DEFAULT_ORDER = { column: :created_at, direction: :asc }.freeze

    option(
      :order,
      type: ClubOrderCriteria, default: DEFAULT_ORDER
    ) do |scope, order|
      scope.order(order.column => order.direction)
    end

    option(
      :my_clubs,
      type: Boolean, description: 'get only club where i am a member', default: false
    ) do |scope, value|
      value ? scope.where(id: current_user.clubs.ids) : scope
    end

    option(
      :other_clubs,
      type: Boolean, description: "get only club where i'm not a member", default: false
    ) do |scope, value|
      value ? scope.where.not(id: current_user.clubs.ids) : scope
    end
  end
end
