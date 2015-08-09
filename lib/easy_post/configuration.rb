module EasyPost
  class Configuration
    attr_accessor :api_endpoint, :cache_dir, :cache_expires_s

    def initialize
      @api_endpoint = 'https://api-pl.easypack24.net/v4/machines?type=0'
      @cache_dir = File.join(ENV['TMPDIR'] || '/tmp', 'cache')
      @cache_expires_s = 3600
    end
  end
end
