require_relative 'contact'
require 'sinatra'

# Route to request and respond with Main Menu
get '/' do
	@crm_app_name = "My CRM" #set up instance variable
  erb :index #view index in embeddable ruby
end

get '/contacts' do # Create a new route the request /contacts and return an erb view
  @contacts = [] # Create some fake contacts data
  @contacts << Contact.new("Yehuda", "Katz", "yehuda@example.com", "Developer")
  @contacts << Contact.new("Mark", "Zuckerberg", "mark@facebook.com", "CEO")
  @contacts << Contact.new("Sergey", "Brin", "sergey@google.com", "Co-Founder")

  erb :contacts
end

get '/contacts/new' do
  erb :new_contact
end

