require './random_challenge.rb'
include RandomChallenge
language, problem = generate_challenge
puts "exercism fetch #{language} #{problem}"
