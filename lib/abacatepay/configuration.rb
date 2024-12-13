# frozen_string_literal: true

module AbacatePay
  # Configuration class for the AbacatePay SDK
  #
  # This class handles all configuration options for the SDK, including
  # API credentials, environment settings, and other customizable options.
  #
  # @api public
  class Configuration
    # @return [String] API token for authentication
    attr_accessor :api_token

    # @return [Symbol] Current environment (:production or :sandbox)
    attr_accessor :environment

    # @return [Integer] Request timeout in seconds
    attr_accessor :timeout

    # @return [String] Base API URL
    attr_reader :api_url

    # Initialize a new configuration with default values
    #
    # @api public
    def initialize
      @environment = :sandbox
      @timeout = 30
      @api_token = nil
    end

    # The name said what is
    VALID_ENVIRONMENTS = %i[production sandbox].freeze

    # Validates the configuration
    #
    # @raise [ConfigurationError] if any required settings are missing or invalid
    # @return [void]
    #
    # @api public
    def validate!
      raise ConfigurationError, "API token is required" if api_token.nil?
      raise ConfigurationError, "Invalid environment. Acceptable values: #{VALID_ENVIRONMENTS.join(', ')}" unless VALID_ENVIRONMENTS.include?(environment)
    end

    # Gets the base API URL based on the environment
    #
    # @return [String] The base API URL
    #
    # @api public
    def api_url
      case environment
      when :production
        "https://api.abacatepay.com/v1"
      when :sandbox, :development
        "https://sandbox.api.abacatepay.com/v1"
      end
    end
  end
end