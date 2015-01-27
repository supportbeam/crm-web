require 'sinatra'

# Route to request and respond with Main Menu
get '/' do
  erb :index #view index in embeddable ruby
end

