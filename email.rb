require 'rubygems'
require 'sinatra'
require 'mandrill'
require 'action_mailer'
require 'pony'
require 'dotenv'
require 'mail'

Dotenv.load

# payload = { "to"=> "Natasha <natasha@newrelic.com>", "subject"=> "hello world", "body"=> "Hi Natasha! Sending you an email via this API I just made." }

get '/form' do
  erb :form
end

post '/form' do
  "You sent #{params}!!!!!!!!!!!!!!!!"
end

payload = { "to"=> "Brantley <bbeaird@gmail.com>", "subject"=> "hello world", "body"=> "Hi Natasha! Sending you an email via this API I just made." }

get '/send-email' do

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

  'Check your email! Hopefully you received the above message!'
end

post '/send-email' do
  "You sent #{params}!!!!!!!!!!!!!!!!"
end