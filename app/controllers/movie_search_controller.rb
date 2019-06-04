class MovieSearchController < ApplicationController
  def index
    command = MMDB::Commands::SearchMovies.call(query: params[:q])

    if command.success?
      render json: command.result
    else
      render json: command.errors, status: 400
    end
  end

  def show
    command = MMDB::Commands::GetMovie.call(imdb_id: params[:id])

    if command.success?
      render json: command.result
    else
      render json: command.errors, status: 404
    end
  end

  def omdb_client
    @omdb_client ||= Omdb::Api::Client.new(api_key: ENV['OMDB_API_KEY'])
  end
end
