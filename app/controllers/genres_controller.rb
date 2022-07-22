class GenresController < ApplicationController
  before_action :set_genre, only: %i[ show update destroy ]
  #before_action :authenticate_user!

  # GET /genres
  def index #Muestra la lista de géneros
    @genres = Genre.all

    render json: @genres, except: [ :created_at, :updated_at] , include: {image: {only: :name}}
  end

  # GET /genres/1
  def show #Muestra el género en detalle
    render json: @genre, except: [:created_at, :updated_at], include: [:movies , :image]# include: {movies: {only: :name}}
  end

  # POST /genres
  def create #creacion de género
    @genre = Genre.new(genre_params)

    if @genre.save
      render json: @genre, status: :created, location: @genre
    else
      render json: @genre.errors, status: :unprocessable_entity
    end
  end

  # PATCH/PUT /genres/1
  def update #modificacion de genero
    if @genre.update(genre_params)
      render json: @genre
    else
      render json: @genre.errors, status: :unprocessable_entity
    end
  end

  # DELETE /genres/1 Eliminación de género
  def destroy
    @genre.destroy
  end

  private
    # Use callbacks to share common setup or constraints between actions.
    def set_genre
      @genre = Genre.find(params[:id])
    rescue ActiveRecord::RecordNotFound #si no encuentra el id del género salva el error 
      render json: "Genre ID not found in DB"
    end

    # Only allow a list of trusted parameters through.
    def genre_params
      params.require(:genre).permit(:name, :image)
    end
end
