# frozen_string_literal: true

module Mutations
  module Resolvers
    # Adds automatic validation error support to mutations.
    module Validation
      # Effect to handle validation errors automatically
      class Effect
        include Dry::Effects::Handler.Interrupt(:validation_error, as: :catch_error)

        def call(&)
          error, result = catch_error(&)

          error ? { errors: result } : result.merge(errors: [])
        end
      end

      extend ActiveSupport::Concern

      included do
        include Dry::Effects.Interrupt(:validation_error)

        # Use a custom resolver that handles the validation_error effect.
        resolve_method :resolve_with_validation

        # Define the errors field for all mutations.
        field :errors, [Types::ValidationErrorType], null: false, description: 'Validation errors'
      end

      # Resolve the mutation with the validation_error effect.
      #
      # In the mutation#resolve method we can stop the flow and return an error
      # at any time using the `validation_error` method.
      #
      # @param args [Any] mutation arguments
      #
      # @return [Hash]
      #
      def resolve_with_validation(**args)
        Effect.new.call do
          public_send(:resolve, **args)
        rescue ActiveRecord::RecordInvalid => e
          validation_error validation_error_data(e.record, e.record.errors, path: [])
        end
      end

      # Wrap the given block with a custom error path. This is useful when we
      # want to define an error on a nested attribute.
      #
      # @param path [<String>]
      #
      # @return [Hash]
      def error_path!(path = [])
        yield
      rescue ActiveRecord::RecordInvalid => e
        validation_error validation_error_data(e.record, e.record.errors, path:)
      end

      # Returns a standard formatted list of validation errors using the
      # ActiveModel::Errors object.
      #
      # @param record [ApplicationRecord]
      # @param errors [ActiveModel::Errors]
      # @param path [<String>]
      #
      # @return [Hash]
      #
      # rubocop:disable Metrics/AbcSize
      def validation_error_data(record, errors, path: [])
        errors.flat_map do |error, _message|
          path = Array(path).map { |p| p.to_s.camelize(:lower) }

          # recurse into associated model errors
          if record&.public_send(error.attribute).respond_to?(:errors)
            attribute_record = record.public_send(error.attribute)

            validation_error_data(attribute_record, attribute_record.errors, path: path + [error.attribute])
          else
            [build_validation_error(error.attribute, error.message, error.type, path:)]
          end
        end
      end
      # rubocop:enable Metrics/AbcSize

      # Helper to build standard formatted validation errors
      #
      # @param attribute [String, Symbol] Attribute related to the error
      # @param message [String] The error message
      # @param error [String] The error code
      # @param path [<String>] Path to the attribute
      #
      # @return [Hash]
      def build_validation_error(attribute, message, error, path: [])
        path = Array(path).map { |p| p.to_s.camelize(:lower) }

        {
          path: ['attributes', *path, attribute.to_s.camelize(:lower)],
          message:,
          attribute: attribute.to_s.camelize(:lower),
          error:
        }
      end
    end
  end
end
