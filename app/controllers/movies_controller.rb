class MoviesController < ApplicationController

  def show
    id = params[:id] # retrieve movie ID from URI route
    @movie = Movie.find(id) # look up movie by unique ID
    # will render app/views/movies/show.<extension> by default
  end
  
  def index
    
#     session = nil
    
#     #2 cases
#     if params[:sort].nil? && session[:sort].nil? == false
#       redirect_to movies_path(:sort=>session[:sort])
#     elsif params[:ratings].nil? && session[:ratings].nil? == false
#       redirect_to movies_path(:ratings=>session[:ratings])
#     end
    
    @movies = Movie.all
    @ratings_to_show = []
    @all_ratings = Movie.all_ratings
    
#     if params[:ratings].nil? == false
#       @ratings_to_show = params[:ratings].keys
#     end
    
#     session[:ratings] = @ratings_to_show #part 3
    
#     #Isn't this line redundant?
#     params[:ratings] = Hash[@ratings_to_show.collect { |item| [item, '1'] } ]

    
    
    if params[:ratings].nil? || params[:ratings].empty?
      @ratings_to_show = @all_ratings
    else
      @ratings_to_show = params[:ratings].keys
      session[:ratings] = @ratings_to_show #part 3
      params[:ratings] = Hash[@ratings_to_show.collect { |item| [item, '1'] } ]
    end
   
    
    
#     if params[:ratings].nil?
#       params[:ratings] = Movie.all_ratings #@all_ratings
#     end 
    
    
    
#     @ratings_to_show = params[:ratings].keys
#     session[:ratings] = @ratings_to_show
#     params[:ratings] = Hash[@ratings_to_show.collect { |item| [item, '1'] } ]
    
#     if params[:ratings].empty? # || params[:ratings].nil?
#       @ratings_to_show = @all_ratings
#     end

    
    
#     #4 cases
#     if params[:sort].nil? && if params[:ratings].nil?
#       puts "BOTH ARE NIL"
      
#     elsif params[:sort].nil? == false && if params[:ratings].nil?
#       puts "params[:rating] IS NIL"
      
#     elsif params[:sort].nil? && if params[:ratings].nil? == false
#       puts "params[:sort] IS NIL"
      
#     elsif params[:sort].nil? == false && if params[:ratings].nil? == false
#       puts "NEITHER ARE NIL"
      
#     end 
      
      
    if params[:sort].nil?
      # do nothing
      puts "------ params[:sort] IS NIL ------"
    elsif params[:sort] == "title"
      @movieCSS = "hilite"
      @releaseCSS = ""
      @movies = Movie.with_ratings(@ratings_to_show).order("title")
      session[:sort] = "title" #part 3
    elsif params[:sort] == "release"
      @releaseCSS = ""
      @releaseCSS = "hilite"
      @movies = Movie.with_ratings(@ratings_to_show).order("release_date")
      session[:sort] = "release" #part 3
    else
      @movies = Movie.with_ratings(@ratings_to_show)
      #unsorted ^^^
    end

    puts "params == #{params}"
    puts "session == #{session}"

#     #2 cases
#     if params[:sort].nil? && session[:sort].nil? == false
#       redirect_to movies_path(:sort=>session[:sort])
#     elsif params[:ratings].nil? && session[:ratings].nil? == false
#       redirect_to movies_path(:ratings=>session[:ratings])
#     end
    
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
