require_relative 'rolodex'
require 'sinatra'
require 'data_mapper'

DataMapper.setup(:default, "sqlite3:database.sqlite3")

class Contact
  include DataMapper::Resource

  #Properties set up getter and setter methods
  #define a property with name of the column as a symbol and the data type it requires
  property :id, Serial # Serial is a type of integer that automatically increments
  property :first_name, String
  property :last_name, String
  property :email, String
  property :note, String
end

DataMapper.finalize # validate any issues with properties or tables defined
DataMapper.auto_upgrade! # Effects any changes to the underlying structure of the tables/columns


# your routes below

$rolodex = Rolodex.new # Create a global variable to be available through out the app

# Route to request and respond with Main Menu
get '/' do
  @page = "Welcome!" #set up instance variable
  erb :index #view index in embeddable ruby
end

get '/contacts' do # Create a new route the request /contacts and return an erb view
  @page = "All Contacts"
  @contacts = Contact.all # .all is a DataMapper method to retreive all records in the database
  erb :contacts
end

get '/contacts/new' do  #GET route to display the form that will let us enter and submit our data
  @page= "Create a New Contact"
  erb :new_contact
end

post '/contacts' do #using the POST method so that we can submit data to our server
  #puts params
   contact = Contact.create( # .create is a DataMapper method that expects a hash to add to the database
    :first_name => params[:first_name],
    :last_name => params[:last_name],
    :email => params[:email],
    :note => params[:note]
  )
  redirect to('/contacts')
end

get "/contacts/:id" do
  @contact = Contact.get(params[:id].to_i) # get is a DataMapper method to return the contact object
  if @contact #if the contact exists
    erb :show_contact #show the webpage
  else
    raise Sinatra::NotFound #show the 404 error if the contact does not exist
  end
end

get "/contacts/:id/edit" do # Request to edit an existing contact by id
  @contact = Contact.get(params[:id].to_i) #find the contact by id
  if @contact
    erb :edit_contact #if the contact exists, show the edit page
  else
    raise Sinatra::NotFound # else show the 404 error
  end
end

put "/contacts/:id" do #Create a route for a put request form submission from edit
  @contact = Contact.get(params[:id].to_i)
  if @contact #if the contact exists, update
    @contact.first_name = params[:first_name]
    @contact.last_name = params[:last_name]
    @contact.email = params[:email]
    @contact.note = params[:note]
    @contact.save # Save in database
    redirect to("/contacts")
  else
    raise Sinatra::NotFound
  end
end

delete "/contacts/:id" do #Route to handle delete contact request
  @page = "Contact Details"
  @contact = Contact.get(params[:id].to_i)
  if @contact
    @contact.destroy
    redirect to("/contacts")
  else
    raise Sinatra::NotFound
  end
end