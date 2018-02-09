class MoviesController < ApplicationController

  def index
    if params[:query].present?
      @movies = Movie.custom_search(params)
    else
      @movies = Movie.all
    end
  end
end
