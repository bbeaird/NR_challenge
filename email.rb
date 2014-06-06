require 'rubygems'
require 'sinatra'
require 'mandrill'
require 'dotenv'
require 'mail'
require 'json'

Dotenv.load

post '/send-email' do
  payload = JSON.parse(request.body.read)
  send_email(payload)
end

def send_email(payload)
  default_from = '<noreply@example.com>'

  Mail.defaults do
    delivery_method :smtp, {
      port: 587,
      address: 'smtp.mandrillapp.com',
      user_name: ENV['MANDRILL_USERNAME'],
      password: ENV['MANDRILL_PASSWORD']
    }
  end

  mail = Mail.deliver do
    from default_from
    to payload["to"]
    subject payload["subject"]
    body payload["body"]
  end
end