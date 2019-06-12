require 'rails_helper'

RSpec.describe 'Movie Search API', type: :request do
  let(:headers) { base_headers }

  describe 'GET /movie_search', :vcr do
    before { get '/movie_search/?q=terminator', headers: headers }

    it 'returns the results for the search term' do
      first_movie = build(:omdb_movie_search_result)

      expect(response).to have_http_status 200
      expect(json[0]).to eq(first_movie)
    end

    context 'when there no results' do
      before { get '/movie_search/?q=-1-1', headers: headers }

      it 'returns an empty array' do
        expect(response).to have_http_status 200
        expect(json).to eq([])
      end
    end
  end

  describe 'GET /movie_search/:id', :vcr do
    before { get '/movie_search/tt0103064' }

    it 'returns the movie details' do
      omdb_movie_details = build(:omdb_movie_details)

      expect(response).to have_http_status 200
      expect(json).to eq(omdb_movie_details)
    end

    context 'when the movie is not found' do
      before { get '/movie_search/ttdontexist' }

      it 'returns an error message' do
        expect(response).to have_http_status 404
        expect(json[:errors]).to be_present
      end
    end
  end
end
