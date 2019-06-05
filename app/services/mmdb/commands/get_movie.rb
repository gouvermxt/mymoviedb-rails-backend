module MMDB
  module Commands
    # Controller command to get a movie details
    class GetMovie
      prepend SimpleCommand

      def initialize(imdb_id:)
        @imdb_id = imdb_id
        @omdb_client = MMDB::OMDBClient.new
      end

      def call
        result = @omdb_client.find_by_id(@imdb_id)

        if result.success?
          result.movie
        else
          errors.add(:errors, result.error)
        end
      end
    end
  end
end
