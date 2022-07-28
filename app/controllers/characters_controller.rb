class CharactersController < ApplicationController
  before_action :set_character, only: %i[ show update destroy ]
  #before_action :authenticate_user!
  
  def index
    if params[:name].present? #si encuentra parametros de :name mostrará los personajes que se correspondan
      @characters = Character.where("name LIKE ?", "%" + params[:name] +"%")
      render json: @characters, only: [:name] , include: {image: {only: :name}}

    elsif params[:age].present? #si encuentra parametros de :age mostrará los personajes que se correspondan
      @characters = Character.where("age = ?", params[:age])
      render json: @characters, only: [:name, :age], include: {movies: {only: :name}}

    elsif params[:weight].present? #si encuentra parametros de :age mostrará los personajes que se correspondan
      @characters = Character.where("weight = ?", params[:weight])
      render json: @characters, only: [:name, :weight], include: {movies: {only: :name}}

    elsif params[:movies].present? #si encuentra parametros de peliculas asociadas mostrará los personajes que se correspondan
      @characters = Character.joins(:movies).where("movies.id = ?", params[:movies]).distinct
      render json: @characters, only: [:name], include: {movies: {only: :name}}

    else
      @characters = Character.all #si no encuentra ningun parametro muestra toda la lista
      render json: @characters, only: [:name, :id], include: {image: {only: :name}}
    end
  end

  # GET /characters/1 personaje en detalle
  def show
    render json: @character, except: [:id, :created_at, :updated_at], include: [:movies , :image]
  end

  # POST /characters creacion de personaje
  def create
    @character = Character.new(character_params)

    if @character.save
      render json: @character, status: :created, location: @character
    else
      render json: @character.errors, status: :unprocessable_entity
    end
  end

  # PATCH/PUT /characters/1 modificacion de personaje
  def update
    if @character.update(character_params)
      render json: @character
    else
      render json: @character.errors, status: :unprocessable_entity
    end
  end

  # DELETE /characters/1 elimina personaje
  def destroy
    @character.destroy
  end

  private
    # Use callbacks to share common setup or constraints between actions.
    def set_character
      @character = Character.find(params[:id])
    rescue ActiveRecord::RecordNotFound #si no encuentra el id del personaje salva el error 
      render json: "Character ID not found in DB"
    end

    # Only allow a list of trusted parameters through.
    def character_params
      params.require(:character).permit(:name, :age, :weight, :history, :image)
    end
end
