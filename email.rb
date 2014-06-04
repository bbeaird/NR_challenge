require 'rubygems'
require 'sinatra'
require 'mandrill'

# Not sure why I had to replace the colons with hashrockets???
payload = { "to"=> "Natasha <natasha@newrelic.com>", "subject"=> "hello world", "body"=> "Hi Natasha! Sending you an email via this API I just made." }

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
  mandrill = Mandrill::API.new ENV['MANDRILL_API_KEY']
  result = mandrill.users.info
end

post '/send-email' do
  # "You sent !!!!!!!!!!!!!!!!!!!!"
  "You sent #{params}!!!!!!!!!!!!!!!!"
end