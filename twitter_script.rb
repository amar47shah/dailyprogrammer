require 'twitter'
require './random_challenge.rb'

include RandomChallenge
client = Twitter::REST::Client.new do |config|
  #twitter auth
end
language, problem = generate_challenge 
client.update("exercism fetch #{language} #{problem}")
