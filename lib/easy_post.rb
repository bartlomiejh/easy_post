require 'faraday'
require 'faraday_middleware'
require 'json'
require 'json-schema'

require 'easy_post/version'
require 'easy_post/configuration'
require 'easy_post/connection'
require 'easy_post/parcel_locker'
require 'easy_post/view_helpers'

require 'easy_post/railtie' if defined?(Rails)

module EasyPost
  class << self
    attr_writer :configuration
  end

  def self.configuration
    @configuration ||= Configuration.new
  end

  def self.configure
    yield(configuration)
  end
end
