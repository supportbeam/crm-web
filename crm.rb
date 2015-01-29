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
  if @contact #if the contact exists
    erb :show_contact #show the webpage
  else
    raise Sinatra::NotFound #show the 404 error if the contact does not exist
  end
end

get "/contacts/:id/edit" do # Request to edit an existing contact by id
  @contact = $rolodex.display_contact(params[:id].to_i) #find the contact by id
  if @contact
    erb :edit_contact #if the contact exists, show the edit page
  else
    raise Sinatra::NotFound # else show the 404 error
  end
end
