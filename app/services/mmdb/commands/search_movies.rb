module MMDB
  module Commands
    # Controller command to search for movies
    class SearchMovies
      prepend SimpleCommand

      def initialize(query)
        @query = query
        @omdb_client = MMDB::OMDBClient.new
      end

      def call
        result = @omdb_client.search(@query)

        if result.success?
          result.movies
        else
          []
        end
      end
    end
  end
end
