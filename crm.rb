require_relative 'rolodex'
require_relative 'contact'
require 'sinatra'

$rolodex = Rolodex.new # Create a global variable to be available through out the app


# Temporary fake data so that we always find contact with id 1000.
$rolodex.add_contact(Contact.new("Johnny", "Bravo", "johnny@bitmakerlabs.com", "Rockstar"))


# Route to request and respond with Main Menu
get '/' do
  @page = "Welcome!" #set up instance variable
  erb :index #view index in embeddable ruby
end

get '/contacts' do # Create a new route the request /contacts and return an erb view
  @page = "All Contacts"
  erb :contacts
end

get '/contacts/new' do  #GET route to display the form that will let us enter and submit our data
  @page= "Create a New Contact"
  erb :new_contact
end

post '/contacts' do #using the POST method so that we can submit data to our server
  #puts params
  new_contact = Contact.new(params[:first_name], params[:last_name], params[:email], params[:note])
  $rolodex.add_contact(new_contact)
  redirect to('/contacts')
end

get "/contacts/:id" do
  @contact = $rolodex.display_contact(params[:id].to_i)
  if @contact
    erb :show_contact
  else
    raise Sinatra::NotFound
  end
end
