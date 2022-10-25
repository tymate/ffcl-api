# frozen_string_literal: true

class ApiController < ActionController::API
  # Rescued errors
  rescue_from Doorkeeper::Errors::InvalidToken, with: :invalid_token
  rescue_from ActiveRecord::RecordNotFound, with: :not_found
  rescue_from ActiveRecord::RecordInvalid, with: :record_invalid

  protected

  def render_validation_error(errors:, code: 422)
    render_error(
      message: errors.full_messages,
      attribute: errors.errors.map(&:type),
      code: code
    )
  end

  def render_error(message:, attribute: nil, code: 400)
    error = {
      error: {
        code: code,
        status: Rack::Utils::HTTP_STATUS_CODES[code],
        messages: message,
        attribute: attribute
      }
    }

    Rails.logger.warn(error)
    render json: error, status: code
  end

  # Returns a 403 for a forbidden token (e.g.: an invalid scope) ;
  # otherwise, returns a 401 (token unknown, revoked, expired)
  #
  def invalid_token(exception)
    code = exception.instance_of?(Doorkeeper::Errors::TokenForbidden) ? 403 : 401

    render_error(
      message: exception.response.description,
      attribute: exception.class.to_s.demodulize.underscore,
      code: code
    )
  end

  def not_found(exception)
    render_error(message: exception.message, attribute: :record_not_found, code: 404)
  end

  def record_invalid(exception)
    render_error(message: exception.message, attribute: :record_invalid, code: 422)
  end
end
