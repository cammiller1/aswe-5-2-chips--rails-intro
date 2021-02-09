class Movie < ActiveRecord::Base
  
class Movie
  
  def all_ratings
    return ['G','PG','PG-13','R']
  end
  
  def self.with_ratings(ratings_list)
  # if ratings_list is an array such as ['G', 'PG', 'R'], retrieve all
  #  movies with those ratings
  # if ratings_list is nil, retrieve ALL movies
    if ratings_list.nil?
      puts "ratings_list is nil ==> retrieve ALL movies"
      self
    else
      puts "ratings_list == #{ratings_list}"
      self.where(ratings: ratings_list)
  end

end
