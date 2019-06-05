# Movie Search API
class MovieSearchController < ApplicationController
  def index
    command = MMDB::Commands::SearchMovies.call(query: params[:q])
    json(command, serializer: OMDBMovieSerializer)
  end

  def show
    command = MMDB::Commands::GetMovie.call(imdb_id: params[:id])

    json(
      command,
      serializer: OMDBMovieSerializer,
      view: :detailed,
      error_status: 404
    )
  end
end
