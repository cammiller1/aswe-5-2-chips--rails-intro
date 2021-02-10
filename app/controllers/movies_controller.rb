class MoviesController < ApplicationController

  def show
    id = params[:id] # retrieve movie ID from URI route
    @movie = Movie.find(id) # look up movie by unique ID
    # will render app/views/movies/show.<extension> by default
  end
  
  def index
#     session = nil

#     puts "params == #{params}"
#
#     if params.nil?
#       puts "------ ERROR params is empty -----"
#     elsif params.empty?
#       params = session.map(&:clone) #deep copy
#     end
#     
#     puts "params == #{params}"
    
    @movies = Movie.all
    @ratings_to_show = []
    @all_ratings = Movie.all_ratings
    
#     if params[:ratings].nil? || params[:ratings].empty?
#       @ratings_to_show = @all_ratings
#     else
#       @ratings_to_show = params[:ratings].keys
#     end
    
    if params[:ratings].nil? == false #|| params[:ratings].empty? == false
      @ratings_to_show = params[:ratings].keys
    end
    
    #Isn't this line redundant?
    params[:ratings] = Hash[@ratings_to_show.collect { |item| [item, '1'] } ]
    
    if params[:sort] == "title"
      @movieCSS = "hilite"
      @releaseCSS = ""
      @movies = Movie.with_ratings(@ratings_to_show).order("title")
    elsif params[:sort] == "release"
      @releaseCSS = ""
      @releaseCSS = "hilite"
      @movies = Movie.with_ratings(@ratings_to_show).order("release_date")
    else
      @movies = Movie.with_ratings(@ratings_to_show)
      #unsorted ^^^
    end
    
#     session = params.map(&:clone) #deep copy
    puts "params == #{params}"
    
  end

  def new
    # default: render 'new' template
  end

  def create
    @movie = Movie.create!(movie_params)
    flash[:notice] = "#{@movie.title} was successfully created."
    redirect_to movies_path
  end

  def edit
    @movie = Movie.find params[:id]
  end

  def update
    @movie = Movie.find params[:id]
    @movie.update_attributes!(movie_params)
    flash[:notice] = "#{@movie.title} was successfully updated."
    redirect_to movie_path(@movie)
  end

  def destroy
    @movie = Movie.find(params[:id])
    @movie.destroy
    flash[:notice] = "Movie '#{@movie.title}' deleted."
    redirect_to movies_path
  end

  private
  # Making "internal" methods private is not required, but is a common practice.
  # This helps make clear which methods respond to requests, and which ones do not.
  def movie_params
    params.require(:movie).permit(:title, :rating, :description, :release_date)
  end
end
