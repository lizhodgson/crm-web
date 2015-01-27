
require 'sinatra'

get '/' do
	html "<h1>Hello World</h1>"
end

get '/hi' do
	puts "PARAMS => #{params}"
	"Hi!"
end

get '/:name' do
	puts "PARAMS => #{params}"
	@name = params[:name].capitalize
	
	erb :index
end