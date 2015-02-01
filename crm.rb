require 'sinatra'
require "sinatra/reloader"
require "data_mapper"
require	'./rolodex'

DataMapper.setup(:default, "sqlite3:database.sqlite3")

class Contact
  include DataMapper::Resource

  property :id, Serial
  property :first_name, String
  property :last_name, String
  property :email, String
  property :note, String
end

DataMapper.finalize
DataMapper.auto_upgrade!

$rolodex = Rolodex.new
contact = $rolodex.find(:id)
#$rolodex.add_contact(Contact.new("Johnny", "Bravo", "johnny@bitmakerlabs.com", "Rockstar"))


get '/' do
	@crm_name = "Liz's CRM"
  erb :index
end

get '/contacts' do
	@contacts = $rolodex.contacts
	erb :contacts
end

get '/contacts/new' do
	erb :new
end

get "/contacts/:id" do
  @contact = $rolodex.find(params[:id].to_i)
  	if @contact
  		erb :show_contact
  	else
  		raise Sinatra::NotFound
		end
end

get "/contacts/:id/edit" do
  @contact = $rolodex.find(params[:id].to_i)
  if @contact
    erb :edit
  else
    raise Sinatra::NotFound
  end
end

post '/contacts' do
	contact = Contact.new(params[:first_name], params[:last_name], params[:email], params[:note])
	$rolodex.add_contact(contact)
	redirect to('/contacts')
end

put "/contacts/:id" do
  @contact = $rolodex.find(params[:id].to_i)
  if @contact
    @contact.first_name = params[:first_name]
    @contact.last_name = params[:last_name]
    @contact.email = params[:email]
    @contact.note = params[:note]
    
    redirect to("/contacts")
  else
    raise Sinatra::NotFound
  end
end

delete "/contacts/:id" do
  @contact = $rolodex.find(params[:id].to_i)
  if @contact
    $rolodex.remove_contact(@contact)
    redirect to("/contacts")
  else
    raise Sinatra::NotFound
  end
end