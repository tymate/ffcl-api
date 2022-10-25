# frozen_string_literal: true

module Mutations
  class BaseMutation < GraphQL::Schema::RelayClassicMutation
    argument_class Types::BaseArgument
    field_class Types::BaseField
    input_object_class Types::BaseInputObject
    object_class Types::BaseObject

    include Mutations::Resolvers::Validation
    include ActionPolicy::GraphQL::Behaviour
    include ActionPolicyExtensions
    include CurrentUserContext

    # Override `doorkeeper_authorize` to authorize the `:app` scope by default
    # and still keep the correct callback name.
    #
    def doorkeeper_authorize!(*scopes)
      return super(*scopes) if scopes.presence

      super :app
    end
  end
end
