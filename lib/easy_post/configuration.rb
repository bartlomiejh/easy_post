module EasyPost
  DEFAULT_API_ENDPOINT = 'https://api-pl.easypack24.net/v4/machines?type=0'

  class Configuration
    attr_accessor :api_endpoint

    def initialize
      @api_endpoint = DEFAULT_API_ENDPOINT
    end
  end
end
