require 'rubygems'
require 'sinatra'
require 'mandrill'

get '/' do
  "Hello World!"
end

get '/form' do
  erb :form
end

post '/form' do
  "You sent #{params}!!!!!!!!!!!!!!!!"
end

get '/send-email' do
  m = Mandrill::API.new
  rendered = m.templates.render 'MyTemplate', [{:name => 'main', :content => 'The main content block'}]
  puts rendered['html'] # print out the rendered HTML
end

post '/send-email' do
  # "You sent !!!!!!!!!!!!!!!!!!!!"
  "You sent #{params}!!!!!!!!!!!!!!!!"
end