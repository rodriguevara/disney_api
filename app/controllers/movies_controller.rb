class MoviesController < ApplicationController
  before_action :set_movie, only: %i[ show update destroy ]
  #before_action :authenticate_user!


  # GET /movies
  def index
    
    if params[:name].present? #si encuentra parametros de :name mostrará los que se correspondan
      @movies = Movie.where("name LIKE ?", Movie.sanitize_sql_like(params[:name]) + "%") #no funciona el sanitize para cuando se coloca el caracter "%" como parámetro
      render json: @movies, only: [:name, :creation_date],  include: {image: {only: :name}}
    elsif params[:genre_id].present? #si encuentra parametros de genero mostrará los que se corresponda
      @movies = Movie.where("genre_id = ?", params[:genre_id])
      render json: @movies, only: [:name, :creation_date, :genre_id] ,  include: {image: {only: :name}}
    elsif params[:order].present? #si encuentra parametros de orden mostrará ordenados Ascendente o descendente segun corresponda
      if params[:order] == "ASC"
        @movies = Movie.order(creation_date: :asc)
        render json: @movies, only: [:name, :creation_date] ,  include: {image: {only: :name}}
      elsif params[:order] == "DESC"
        @movies = Movie.order(creation_date: :desc)
        render json: @movies, only: [:name, :creation_date],  include: {image: {only: :name}}
      else
        @movies = Movie.all
      render json: @movies, only: [:name, :creation_date], include: {image: {only: :name}}

      end
    else #si no encuentra ningun parametro muestra toda la lista
      @movies = Movie.all
      render json: @movies, only: [:name, :creation_date, :id], include: {image: {only: :name}}
    end
  end
  
 

  # GET /movies/1
  def show #muestra el detalle de la película/serie
    render json: @movie, except: [:id, :created_at, :updated_at], include: [:characters , :image]
    

  end

  # POST /movies
  def create #creacion de peli
    @movie = Movie.new(movie_params)

    if @movie.save
      render json: @movie, status: :created, location: @movie
    else
      render json: @movie.errors, status: :unprocessable_entity
    end
  end

  # PATCH/PUT /movies/1
  def update #modificacion de peli
    if @movie.update(movie_params)
      render json: @movie
    else
      render json: @movie.errors, status: :unprocessable_entity
    end
  end

  # DELETE /movies/1 Elimina peli
  def destroy
    @movie.destroy
  end

  private
    # Use callbacks to share common setup or constraints between actions.
    def set_movie
      @movie = Movie.find(params[:id])
    rescue ActiveRecord::RecordNotFound #si no encuentra el id de la peli/serie salva el error 
      render json: "Movie ID not found in DB"
    end

    # Only allow a list of trusted parameters through.
    def movie_params
      params.require(:movie).permit(:name, :creation_date, :rating, :genre_id, :image)
    end
end
