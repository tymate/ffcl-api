# frozen_string_literal: true

module Types
  class QueryType < Types::BaseObject
    description 'Root queries'

    # Show queries
    SHOW_QUERIES_FOR_SINGLE_RECORDS = %w[user club reading_session].freeze

    # Custom show queries
    field :current_user, Types::UserType, authorize: true, null: true

    field :node, GraphQL::Types::Relay::Node,
          authorize: true, null: true,
          description: 'Fetches an object given its ID' do
      argument :id, ID, required: true
    end

    # Index queries
    field :clubs, Types::ClubType.connection_type,
          resolver: Resolvers::ClubResolver,
          preauthorize: { to: :index?, with: ClubPolicy },
          connection: GraphQL::Connections::Stable,
          null: false

    # Internal methods
    def self.define_show_field(query)
      graphql_type = "Types::#{query.camelcase}Type".safe_constantize

      field query.to_sym, graphql_type, authorize: true, null: true do
        argument :id, ID, required: true, loads: graphql_type
      end
    end

    def self.define_show_method(query)
      define_method query do |arguments|
        arguments[:id]
      end
    end

    # Define queries for single records following the values in the constant above.
    SHOW_QUERIES_FOR_SINGLE_RECORDS.each do |query|
      define_show_field(query)
      define_show_method(query)
    end

    def node(id:)
      context.schema.object_from_id(id, context)
    end
  end
end
