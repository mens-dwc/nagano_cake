class Public::GenresController < ApplicationController
  def show
    @genre = Genre.find(params[:id])
    @items = Item.where(genre_id: @genre.id)
    @genres = Genre.all
    #@genress =Genre.where(is_genres_status: 'false')
    #@items=Item.all
  end
end
