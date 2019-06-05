FactoryBot.define do
  factory :omdb_movie_details, class: Hash do
    actors do
      'Arnold Schwarzenegger, Linda Hamilton, Edward Furlong, Robert Patrick'
    end

    plot do
      'A cyborg, identical to the one who failed to kill Sarah Connor, must ' \
      'now protect her teenage son, John Connor, from a more advanced ' \
      'and powerful cyborg.'
    end

    poster do
      'https://m.media-amazon.com/images/M/MV5BMGU2NzRmZjUtOGUxYS00ZjdjLWEwZWItY2NlM2JhNjkxNTFmXkEyXkFqcGdeQXVyNjU0OTQ0OTY@._V1_SX300.jpg'
    end

    country { 'USA' }
    director { 'James Cameron' }
    genre { 'Action, Sci-Fi' }
    language { 'English, Spanish' }
    runtime { '137 min' }
    title { 'Terminator 2: Judgment Day' }
    writer { 'James Cameron, William Wisher' }
    year { '1991' }
    imdb_rating { '8.5' }
    imdb_id { 'tt0103064' }

    initialize_with { attributes }
  end

  factory :omdb_movie_search_result, class: Hash do
    title { 'Terminator 2: Judgment Day' }
    year { '1991' }
    imdb_id { 'tt0103064' }

    poster do
      'https://m.media-amazon.com/images/M/MV5BMGU2NzRmZjUtOGUxYS00ZjdjLWEwZWItY2NlM2JhNjkxNTFmXkEyXkFqcGdeQXVyNjU0OTQ0OTY@._V1_SX300.jpg'
    end

    initialize_with { attributes }
  end
end
