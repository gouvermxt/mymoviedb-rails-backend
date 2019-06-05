# Serializes an OMDB Movie
class OMDBMovieSerializer < Blueprinter::Base
  identifier :imdb_id

  fields(:poster, :title, :year)

  view :detailed do
    fields(
      :actors,
      :plot,
      :country,
      :director,
      :genre,
      :language,
      :runtime,
      :writer,
      :imdb_rating
    )
  end
end
