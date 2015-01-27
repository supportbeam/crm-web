require 'sinatra'

# Route to request and respond with Main Menu
get '/' do
	@crm_app_name = "My CRM" #set up instance variable
  erb :index #view index in embeddable ruby
end

