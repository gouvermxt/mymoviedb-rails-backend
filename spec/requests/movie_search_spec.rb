require 'rails_helper'

RSpec.describe 'Movie Search API', type: :request do
  let(:headers) { base_headers }

  describe 'GET /movie_search', :vcr do
    before { get '/movie_search/?q=terminator', headers: headers }

    context 'when there are results' do
      it 'returns the results for the search term' do
        expect(json[0][:title]).to match(/terminator/i)
      end

      it 'returns status code 200' do
        expect(response).to have_http_status 200
      end
    end

    context 'when theres no results' do
      before { get '/movie_search/?q=-1-1', headers: headers }

      it 'returns an empty array' do
        expect(json).to eq([])
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
        expect(json[:title]).to match(/Terminator 2: Judgment Day/i)
      end
    end

    context 'when the movie is not found' do
      before { get '/movie_search/ttdontexist' }

      it 'returns a 404 code' do
        expect(response).to have_http_status 404
      end
    end
  end
end
