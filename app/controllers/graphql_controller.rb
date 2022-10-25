# frozen_string_literal: true

class GraphqlController < ActionController::API
  include GraphQL::Extras::Controller

  def execute
    graphql(
      schema: FfclApiSchema,
      context: { doorkeeper_token: }
    )
  rescue StandardError => e
    handle_error(e)
  end

  private

  def handle_error(err)
    logger.error err.message
    logger.error err.backtrace.join("\n")

    render(
      json: { errors: [{ message: err.message, backtrace: err.backtrace }], data: {} },
      status: :internal_server_error
    )
  end
end
