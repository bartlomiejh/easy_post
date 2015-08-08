module EasyPost
  class Configuration
    attr_accessor :api_endpoint

    def initialize
      @api_endpoint = 'https://api-pl.easypack24.net/v4/machines?type=0'
    end
  end
end
