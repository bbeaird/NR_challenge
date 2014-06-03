require 'rubygems'
require 'sinatra'

get '/' do
  "Hello World!"
end

post '/send-email' do
  # "You sent !!!!!!!!!!!!!!!!!!!!"
  "You sent #{params}!!!!!!!!!!!!!!!!"
end

get '/form' do
  erb :form
end

post '/form' do
  "You sent #{params}!!!!!!!!!!!!!!!!"
end