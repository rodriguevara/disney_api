# == Schema Information
#
# Table name: character_movies
#
#  id           :integer          not null, primary key
#  created_at   :datetime         not null
#  updated_at   :datetime         not null
#  character_id :integer          not null
#  movie_id     :integer          not null
#
# Indexes
#
#  index_character_movies_on_character_id  (character_id)
#  index_character_movies_on_movie_id      (movie_id)
#
# Foreign Keys
#
#  character_id  (character_id => characters.id)
#  movie_id      (movie_id => movies.id)
# Tabla interrelacional entre personajes y películas
class CharacterMovie < ApplicationRecord
  belongs_to :character
  belongs_to :movie
end
