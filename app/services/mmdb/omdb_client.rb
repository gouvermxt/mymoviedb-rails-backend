require 'facets/hash/deep_rekey'

module MMDB
  # Client for OMDB API
  class OMDBClient
    include HTTParty
    base_uri 'https://www.omdbapi.com'.freeze
    default_params apikey: ENV['OMDB_API_KEY']

    OMDB_JSON_SEARCH_KEY = 'Search'.freeze
    OMDB_JSON_RESPONSE_KEY = 'Response'.freeze

    def search(query, limit)
      response = self.class.get('/', query: { s: query })
      results = parse_response(response)
      get_search_results(results, limit)
    end

    def find_by_id(imdb_id)
      response = self.class.get('/', query: { i: imdb_id })
      result = parse_response(response)

      if result[:success?]
        create_struct(movie: result, success?: true)
      else
        create_struct(result)
      end
    end

    private

    def parse_response(response)
      result = JSON.parse(response.body)
      success = result[OMDB_JSON_RESPONSE_KEY] == 'True'
      result.merge!(success?: success)
    end

    def get_search_results(results, limit)
      limit = limit.present? ? limit.to_i - 1 : nil

      if results[:success?]
        movie_results = results[OMDB_JSON_SEARCH_KEY][0..limit]
        movies = movie_results.map do |result|
          create_struct(result)
        end

        create_struct(movies: movies, success?: true)
      else
        create_struct(results)
      end
    end

    # Transforms the OMDB parsed JSON result into a Struct to be returned,
    # because the JSON serializer lib in use does not support serializing hashs
    def create_struct(hash)
      hash = normalize_keys(hash)
      Struct.new(*hash.keys).new(*hash.values)
    end

    # OMDB API returns capitalized camel cased json keys. Transforms it to
    # snake case
    def normalize_keys(hash)
      hash.deep_rekey { |k| k.to_s.underscore.to_sym }
    end
  end
end
