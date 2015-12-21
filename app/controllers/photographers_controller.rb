class PhotographersController < ApplicationController
 # before_filter :authenticate_user!, :except => [:index]
  def index
    #  @photographer = Photographer.all    
  end

  def profile
    #binding.pry
   #@photographer= current_photographer
  end

  def show
  end

  def new
    #@Photographer= Photographer.new
  end

  def edit
  end

  def delete
  end
end
