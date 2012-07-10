require 'uri'
require 'faraday'

module Sociable
  module Friends
    module Facebook

      def load_friends(twitter_handle)
        ids_response = get("1/friends/ids.json?cursor=-1&screen_name=#{twitter_handle}")
        ids=JSON.parse(ids_response[:body])['ids']
        rv=[]
        ids.flatten.each_slice(100) do |ids|
          users_response=get("1/friends/ids.json?cursor=-1&screen_name=#{twitter_handle}")
          rv += JSON.parse(users_response[:body])
        end
        rv
      end

      def get(path)
        request(:get, path)
      end


     # Perform an HTTP request
      def request(method, path)
        uri = 'http://api.twitter.com/'+path
        connection.url_prefix = options[:endpoint] || @endpoint
        connection.run_request(:get, path, nil, nil)
      rescue Faraday::Error::ClientError
        raise Sociable::Error::ClientError
      end

      def connection
           @connection ||= Faraday.new(@endpoint)
      end




    end
  end
end