require 'rails_helper'

RSpec.describe 'Movie Search API', type: :request do
  let(:headers) { base_headers }

  describe 'GET /movie_search', :vcr do
    context 'when there are results' do
      before { get '/movie_search/?q=terminator', headers: headers }

      it 'returns the results for the search term' do
        first_movie = build(:omdb_movie_search_result)
        expect(json[0]).to eq(first_movie)
      end

      it 'returns status code 200' do
        expect(response).to have_http_status 200
      end
    end

    context 'when there no results' do
      before { get '/movie_search/?q=-1-1', headers: headers }

      it 'returns an empty array' do
        expect(json).to eq([])
      end

      it 'returns status code 200' do
        expect(response).to have_http_status 200
      end
    end
  end

  describe 'GET /movie_search/:id', :vcr do
    context 'when the movie is found' do
      before { get '/movie_search/tt0103064' }

      it 'returns status code 200' do
        expect(response).to have_http_status 200
      end

      it 'returns the movie details' do
        omdb_movie_details = build(:omdb_movie_details)
        expect(json).to eq(omdb_movie_details)
      end
    end

    context 'when the movie is not found' do
      before { get '/movie_search/ttdontexist' }

      it 'returns a 404 code' do
        expect(response).to have_http_status 404
      end

      it 'returns an error message' do
        expect(json[:errors]).to be_present
      end
    end
  end
end
