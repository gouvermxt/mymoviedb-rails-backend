module MMDB
  module Commands
    # Controller command to search for movies
    class SearchMovies
      prepend SimpleCommand

      def initialize(movie_search_params)
        @query = movie_search_params[:q]
        @limit = movie_search_params[:limit]
        @omdb_client = MMDB::OMDBClient.new
      end

      def call
        result = @omdb_client.search(@query, @limit)

        if result.success?
          result.movies
        else
          []
        end
      end
    end
  end
end
