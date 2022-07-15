# == Schema Information
#
# Table name: characters
#
#  id         :integer          not null, primary key
#  age        :integer
#  history    :text
#  name       :string
#  weight     :integer
#  created_at :datetime         not null
#  updated_at :datetime         not null
#
class Character < ApplicationRecord
    has_many :character_movies
    has_many :movies, through: :character_movies
    has_one_attached :image, :dependent => :destroy
end
