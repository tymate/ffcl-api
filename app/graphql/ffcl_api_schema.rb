# frozen_string_literal: true

class FfclApiSchema < GraphQL::Schema
  mutation(Types::MutationType)
  query(Types::QueryType)

  # Union and Interface Resolution
  def self.resolve_type(abstract_type, obj, ctx)
    if abstract_type == GraphQL::Types::Relay::Node
      "Types::#{obj.class}Type".safe_constantize
    else
      super(abstract_type, obj, ctx)
    end
  end

  # Return a string UUID for `object`
  def self.id_from_object(object, _type_definition, _query_ctx)
    object.to_gid.to_param
  end

  # Given a string UUID, find the object
  def self.object_from_id(id, _query_ctx)
    GlobalID.find(id)
  end

  # Exceptions handlers
  #
  # 401: Unauthorized
  rescue_from(Doorkeeper::Errors::InvalidToken) do |err|
    raise GraphQL::ExecutionError.new(
      err.response.description,
      extensions: {
        code: err.response.status
      }
    )
  end

  # 403: Forbidden
  rescue_from(ActionPolicy::Unauthorized) do |err|
    raise GraphQL::ExecutionError.new(
      err.result.message,
      extensions: {
        code: :forbidden,
        fullMessages: err.result.reasons.full_messages,
        details: err.result.reasons.details
      }
    )
  end

  # 404: Not Found
  rescue_from(ActiveRecord::RecordNotFound) do |err, _obj, _args, _ctx, _field|
    raise GraphQL::ExecutionError.new(
      err.message,
      extensions: {
        code: :not_found
      }
    )
  end
end
