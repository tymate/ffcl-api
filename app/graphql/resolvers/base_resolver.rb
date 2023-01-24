# frozen_string_literal: true

require 'search_object'
require 'search_object/plugin/graphql'

module Resolvers
  class BaseResolver < GraphQL::Schema::Resolver
    include ActionPolicy::GraphQL::Behaviour
    include CurrentUserContext
    include ActionPolicyExtensions

    argument_class Types::BaseArgument
  end
end
