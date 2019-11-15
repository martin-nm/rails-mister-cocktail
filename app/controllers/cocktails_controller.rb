require 'open-uri'

class CocktailsController < ApplicationController

  def index
    @cocktails = Cocktail.all
  end

  def new
    @cocktail = Cocktail.new
  end

  def create
    @cocktail = Cocktail.new(cocktail_params)
    if @cocktail.save
      redirect_to cocktail_path(@cocktail)
    else
      render :new
    end
  end

  def show
    @cocktail = Cocktail.find(params[:id])
    @dose = Dose.new
    parse = @cocktail.name.downcase
    url = "https://www.thecocktaildb.com/api/json/v1/1/search.php?s=#{parse}"
    cocktail_db_serialized = open(url).read
    cocktail_db = JSON.parse(cocktail_db_serialized)
    @img_url = cocktail_db['drinks'][0]['strDrinkThumb']
    @category = cocktail_db['drinks'][0]['strCategory']
    @iba = cocktail_db['drinks'][0]['strIBA']
    @recipe = cocktail_db['drinks'][0]['strInstructions']
  end

  private

  def cocktail_params
    params.require(:cocktail).permit(:name)
  end
end
