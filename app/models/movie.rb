class Movie < ActiveRecord::Base
  
  def self.all_ratings
    return ['G','PG','PG-13','R']
  end

  def self.with_ratings(ratings_list)
  # if ratings_list is an array such as ['G', 'PG', 'R'], retrieve all
  #  movies with those ratings
  # if ratings_list is nil, retrieve ALL movies
    puts "--------------------------------------------------------------------"
    if ratings_list.nil? || ratings_list.empty?
      puts "ratings_list is nil ==> retrieve ALL movies"
      puts "--------------------------------------------------------------------"
      return self.all
    else
      puts "ratings_list == #{ratings_list}"
      puts "--------------------------------------------------------------------"
      return self.where(rating: ratings_list)
    end
    
  end
  
end