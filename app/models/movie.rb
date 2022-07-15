# == Schema Information
#
# Table name: movies
#
#  id            :integer          not null, primary key
#  creation_date :date
#  name          :string
#  rating        :integer
#  created_at    :datetime         not null
#  updated_at    :datetime         not null
#  genre_id      :integer          not null
#
# Indexes
#
#  index_movies_on_genre_id  (genre_id)
#
# Foreign Keys
#
#  genre_id  (genre_id => genres.id)
#
class Movie < ApplicationRecord
  belongs_to :genre
  has_many :character_movies
  has_many :characters, through: :character_movies
  has_one_attached :image, :dependent => :destroy
end
