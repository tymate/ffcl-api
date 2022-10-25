# frozen_string_literal: true

module ActionPolicyExtensions
  # See https://github.com/palkan/action_policy/blob/aa686b635e8705992084b43975a0738d41fd8479/lib/action_policy/behaviours/scoping.rb#L13
  # Monkey-patched to always add the doorkeeper_token in the authorization context.
  #
  def authorized_scope(target, type: nil, as: :default, scope_options: nil, **options)
    options[:context] = { doorkeeper_token: }
    super(target, type:, as:, scope_options:, **options)
  end

  # See https://github.com/palkan/action_policy/blob/aa686b635e8705992084b43975a0738d41fd8479/lib/action_policy/behaviour.rb#L37
  # Monkey-patched to always add the doorkeeper_token in the authorization context.
  #
  def authorize!(record = :__undef__, to: nil, **options)
    options[:context] = { doorkeeper_token: }
    super(record, to:, **options)
  end

  # See https://github.com/palkan/action_policy-graphql/blob/master/lib/action_policy/graphql/authorized_field.rb#L100
  # rubocop: disable Style/ClassAndModuleChildren
  module ActionPolicy::GraphQL::AuthorizedField
    # Monkey-patched to always add the context (with the doorkeeper_token) to the authorize options.
    class AuthorizeFieldExtension
      def resolve(context:, object:, arguments:, **_rest)
        if @raise
          object.authorize! object.object, to: @to, **options.merge(context:)
          yield object, arguments
        elsif object.allowed_to?(@to, object.object, **options.merge(context:))
          yield object, arguments
        end
      end
    end
  end
  # rubocop: enable Style/ClassAndModuleChildren
end
