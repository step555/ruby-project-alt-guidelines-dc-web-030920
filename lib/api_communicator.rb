# require 'rest-client'
# require 'json'
# require 'pry'
# require 'awesome_print'

# def return_response_hash(url)
#   response_string = RestClient.get(url)
#   response_hash = JSON.parse(response_string)
#   response_hash
# end

# def get_character_movies_from_api(character_name)
#   response_hash = return_response_hash('https://icanhazdadjoke.com/')
#     binding.pry
# #   character_info = response_hash["results"].find { |result| result["name"] == character_name.strip}
# #   movie_urls = character_info["films"]
# #   movie_hash = movie_urls.map do |url|
# #     return_response_hash(url)
# #   end
# #   movie_hash
# end

# # def print_movies(films)
# #     # some iteration magic and puts out the movies in a nice list
# #     count = 1
# #     films.each do |h|
# #       puts "*************************"
# #       puts "#{count}. #{h["title"]}"
# #       count += 1
# #       # binding.pry
# #     end
# #   end
  
# #   def show_character_movies(character)
# #     puts "Searching for #{character}..."
# #     films = get_character_movies_from_api(character)
# #     print_movies(films)
# #   end