module ITunes
  module Request
    # @private
    private

      # Perform an HTTP GET request
      def request(request_type, params)
        url = '/WebObjects/MZStoreServices.woa/wa/ws' + request_type

        response = connection.get do |req|
          req.url url, params
        end
        response.body
      end

      def connection
        options = {
          :headers => {'Accept' => "application/json", 'User-Agent' => user_agent},
          :url => api_endpoint,
        }

        Faraday::Connection.new(options) do |builder|
          builder.adapter(adapter)
          builder.use Faraday::Response::ParseJson
          builder.use Faraday::Response::Rashify
        end
      end

  end
end