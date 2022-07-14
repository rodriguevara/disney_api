class CreateCharacterMovies < ActiveRecord::Migration[7.0]
  def change
    create_table :character_movies do |t|
      t.references :character, null: false, foreign_key: true
      t.references :movie, null: false, foreign_key: true

      t.timestamps
    end
  end
end
