# Movie Search API
class MovieSearchController < ApplicationController
  skip_before_action :authenticate_user

  def index
    command = MMDB::Commands::SearchMovies.call(movie_search_params)
    json(command, serializer: OMDBMovieSerializer)
  end

  def show
    command = MMDB::Commands::GetMovie.call(params[:id])

    json(
      command,
      serializer: OMDBMovieSerializer,
      view: :detailed,
      error_status: 404
    )
  end

  private

  def movie_search_params
    params.permit(:q, :limit)
  end
end
