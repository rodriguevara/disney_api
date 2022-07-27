# This file should contain all the record creation needed to seed the database with its default values.
# The data can then be loaded with the bin/rails db:seed command (or created alongside the database with db:setup).
#
# Examples:
#
#   movies = Movie.create([{ name: "Star Wars" }, { name: "Lord of the Rings" }])
#   Character.create(name: "Luke", movie: movies.first)
Genre.create(name: "action")
Genre.create(name: "terror")
Movie.create(name: "Spiderman: Far from home", creation_date: "05/07/2018", rating: 3, genre_id: 1)