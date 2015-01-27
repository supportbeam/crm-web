require_relative 'rolodex'
require_relative 'contact'
require 'sinatra'

$rolodex = Rolodex.new # Create a global variable to be available through out the app

# Route to request and respond with Main Menu
get '/' do
	@crm_app_name = "My CRM" #set up instance variable
  erb :index #view index in embeddable ruby
end

get '/contacts' do # Create a new route the request /contacts and return an erb view
  erb :contacts
end

get '/contacts/new' do
  erb :new_contact
end

