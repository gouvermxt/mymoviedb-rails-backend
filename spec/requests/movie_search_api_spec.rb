require 'rails_helper'

RSpec.describe 'Movie Search API', type: :request do
  describe 'GET /movie_search', :vcr do
    let(:query) { 'terminator' }
    let(:search_movie) do
      get "/movie_search/?q=#{query}", headers: base_headers
    end

    it 'returns the results for the search term' do
      search_movie
      first_movie = build(:omdb_movie_search_result)

      expect(response).to have_http_status 200
      expect(json[0]).to eq(first_movie)
    end

    context 'when there no results' do
      let(:query) { '-1-1' }

      it 'returns an empty array' do
        search_movie
        expect(response).to have_http_status 200
        expect(json).to eq([])
      end
    end
  end

  describe 'GET /movie_search/:id', :vcr do
    let(:movie_id) { 'tt0103064' }
    let(:get_movie) { get "/movie_search/#{movie_id}", headers: base_headers }

    it 'returns the movie details' do
      get_movie
      omdb_movie_details = build(:omdb_movie_details)

      expect(response).to have_http_status 200
      expect(json).to eq(omdb_movie_details)
    end

    context 'when the movie is not found' do
      let(:movie_id) { 'ttdontexist' }

      it 'returns an error message' do
        get_movie
        expect(response).to have_http_status 404
        expect(json[:errors]).to be_present
      end
    end
  end
end
