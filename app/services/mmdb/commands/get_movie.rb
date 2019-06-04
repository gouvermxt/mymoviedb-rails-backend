require 'omdb/api'

module MMDB
  module Commands
    # Gets a movie details given its IMDB id
    class GetMovie
      prepend SimpleCommand

      def initialize(imdb_id:)
        @imdb_id = imdb_id
        @omdb_client = Omdb::Api::Client.new(api_key: ENV['OMDB_API_KEY'])
      end

      def call 
        result = @omdb_client.find_by_id(@imdb_id)

        # using instance_variable... because there's a bug in OMDB gem avoiding
        # access to result attributes
        if result.instance_variable_defined?(:@error)
          errors.add(:errors, result.instance_variable_get(:@error))
        else
          result
        end
      end
    end
  end
end

