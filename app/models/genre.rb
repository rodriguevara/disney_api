# == Schema Information
#
# Table name: genres
#
#  id         :integer          not null, primary key
#  name       :string
#  created_at :datetime         not null
#  updated_at :datetime         not null
#
class Genre < ApplicationRecord
    has_many :movies
    has_one_attached :image, :dependent => :destroy
end
