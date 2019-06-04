require 'omdb/api'

module MMDB
  module Commands
    # Search for movies on OMDB
    class SearchMovies
      prepend SimpleCommand

      def initialize(query:)
        @query = query
        @omdb_client = Omdb::Api::Client.new(api_key: ENV['OMDB_API_KEY'])
      end

      def call
        result = @omdb_client.search(@query)

        # using instance_variable... because there's a bug in OMDB gem avoiding
        # access to result attributes
        if result.instance_variable_defined?(:@Error)
          []
        else
          result
        end
      end
    end
  end
end
