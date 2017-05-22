# This file should contain all the record creation needed to seed the database with its default values.
# The data can then be loaded with the rails db:seed command (or created alongside the database with db:setup).
#
# Examples:
#
#   movies = Movie.create([{ name: 'Star Wars' }, { name: 'Lord of the Rings' }])
#   Character.create(name: 'Luke', movie: movies.first)
require 'json'
require 'open-uri'
require 'open-uri'
require 'nokogiri'

# puts 'Cleaning database...'
# Ingredient.destroy_all

# puts 'Creating ingredients...'

# url = 'http://www.thecocktaildb.com/api/json/v1/1/list.php?i=list'
# cocktail_serialized = open(url).read
# cocktail = JSON.parse(cocktail_serialized)


# cocktail["drinks"].each do |ingredient|
#   url = "http://www.thecocktaildb.com/images/ingredients/#{ingredient["strIngredient1"]}.png"
#   new_ingredient = Ingredient.create(name: ingredient["strIngredient1"])
#   new_ingredient.photo_url = url
# end

puts 'Cleaning cocktail database...'
Cocktail.destroy_all

puts 'Creating cocktails...'

cocktails = []

cocktails_name = []
cocktails_img = []
i = [*0..55]
i.each do |i|
  html_file = open("http://www.liquor.com/recipes/page/#{i + 1}/")
  html_doc = Nokogiri::HTML(html_file)

  html_doc.search('.archive-item-headline a').each do |element|
    cocktails_name << element.text
  end

  html_doc.search('.image.archive-item-image a img:first-child').each do |element|
    cocktails_img << "http:" + element.attribute("src")
  end

end

cocktails_images = []

cocktails_img.each_with_index { |img, index|
  if index.odd?
    cocktails_images << img
  end
}

cocktails_name.each_with_index do |name, i|
  cocktails << { name: name, img: cocktails_images[i] }
end

cocktails.each do |cocktail|
  Cocktail.create(name: cocktail[:name], img: cocktail[:img])
end

puts 'Finished!'
