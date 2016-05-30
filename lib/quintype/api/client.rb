module Quintype::API
  class ClientException < Exception
    attr_reader :response

    def initialize(message, response)
      super(message)
      @response = response
    end
  end

  class Client
    class << self
      def establish_connection(host, adapter = nil)
        connection = Faraday.new(host) do |conn|
          conn.request  :json
          conn.response :json, :content_type => /\bjson$/
          conn.adapter(adapter || Faraday.default_adapter)
        end
        @client = new(connection)
      end

      def instance
        @client
      end
    end

    def initialize(conn)
      @conn = conn
    end

    def get_config
      get("/api/v1/config")
    end

    def get_story_by_slug(slug)
      get("/api/v1/stories-by-slug", slug: slug)
    end

    def post_bulk(requests)
      post("/api/v1/bulk", requests)
    end

    private
    def get(url, params = {})
      parse_response @conn.get(url, params)
    end

    def post(url, body, params = {})
      parse_response @conn.post(url, body, params)
    end

    def parse_response(response)
      if(response.status < 400)
        response
      else
        raise ClientException.new("API returned a non successful response", response)
      end
    end
  end
end
