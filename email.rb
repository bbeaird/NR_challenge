require 'rubygems'
require 'sinatra'
require 'mandrill'
require 'dotenv'
require 'mail'
require 'json'
require 'net/http'

Dotenv.load

# payload = { "to": "Brantley <bbeaird@gmail.com>", "subject": "hello world", "body": "Hi Natasha! Sending you an email via this API I just made." }

get '/send-email' do
  erb :form
end

post '/send-email' do


  # content_type: json

  # curl -X POST -H "Accept: application/json" -d '{ "to": "Brantley <bbeaird@gmail.com>", "subject": "hello world", "body": "Hi Natasha! Sending you an email via this API I just made." }' http://localhost:9393/send-email

  # curl -X POST -H "Content-Type: application/json" -d '{ "to": "Brantley <bbeaird@gmail.com>", "subject": "hello world", "body": "Hi Natasha! Sending you an email via this API I just made." }' http://localhost:9393/send-email

   # curl -X POST -H "Accept: application/json" -d '{ "to": "Brantley <bbeaird@gmail.com>", "subject": "hello world", "body": "Hi Natasha! Sending you an email via this API I just made." }' http://localhost:9393/send-email

   # curl -X POST -d '"hello dolly":45 ' http://localhost:9393/send-email

   # curl -v -H "Accept: application/json" -H "Content-type: application/json" -X POST -d ' {"user":{"first_name":"firstname","last_name":"lastname","email":"email@email.com","password":"app123","password_confirmation":"app123"}}'  http://localhost:9393/send-email

  # p "request......"
  # p request
  # p "request.json"
  # p request.JSON
  p "params......."
  p params
  # payload = JSON params
  payload = JSON.parse(request.body.read)
  p "payload is............#{payload}"
  p "payload['to'] is.........see next line"
  p payload["to"]

  Mail.defaults do
    delivery_method :smtp, {
      port: 587,
      address: 'smtp.mandrillapp.com',
      user_name: ENV['MANDRILL_USERNAME'],
      password: ENV['MANDRILL_PASSWORD']
    }
  end

  mail = Mail.deliver do
    to payload["to"]
    from '<noreply@example.com>'
    subject payload["subject"]

    text_part do
      body payload["body"]
    end
  end

  "Check your email! You should've received the above message!"
end