module EasyPost
  CONTRACT = {
    type: 'object',
    required: ['_embedded'],
    properties: {
      _embedded: {
        type: 'object',
        required: ['machines'],
        properties: {
          machines: {
            type: 'list'
          }
        }
      }
    }
  }
  CACHE_DIR = File.join(ENV['TMPDIR'] || '/tmp', 'cache')
  CACHE_EXPIRES_S = 3600

  module Connection
    def self.api_client
      Faraday.new(EasyPost.configuration.api_endpoint) do |faraday|
        faraday.response :caching do
          # @review: Rails.cache can be used
          ActiveSupport::Cache::FileStore.new(
            EasyPost.configuration.cache_dir,
            namespace: 'easy_post',
            expires_in: EasyPost.configuration.cache_expires_s
          )
        end
        faraday.adapter Faraday.default_adapter
      end
    end

    def self.get
      response = api_client.get
      JSON::Validator.validate!(CONTRACT, response.body)
      JSON.parse(response.body)['_embedded']['machines']
    end
  end
end
