require_relative 'rolodex'
require_relative 'contact'
require 'sinatra'

$rolodex = Rolodex.new # Create a global variable to be available through out the app

# Route to request and respond with Main Menu
get '/' do
	@crm_app_name = "My CRM" #set up instance variable
	@title = "MY CRM"
  erb :index #view index in embeddable ruby
end

get '/contacts' do # Create a new route the request /contacts and return an erb view
  @title = "All Contacts"
  erb :contacts
end

get '/contacts/new' do  #GET route to display the form that will let us enter and submit our data
  @title = "Create a New Contact"
  erb :new_contact
end

post '/contacts' do #using the POST method so that we can submit data to our server
  #puts params
  new_contact = Contact.new(params[:first_name], params[:last_name], params[:email], params[:note])
  $rolodex.add_contact(new_contact)
  redirect to('/contacts')
end

