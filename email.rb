require 'rubygems'
require 'sinatra'
require 'mandrill'
require 'dotenv'
require 'mail'
require 'json'

Dotenv.load

# payload = { "to": "Brantley <bbeaird@gmail.com>", "subject": "hello world", "body": "Hi Natasha! Sending you an email via this API I just made." }

# curl -X POST -H "Content-Type: application/json" -d '{ "to": "Brantley <bbeaird@gmail.com>", "subject": "hello world", "body": "Hi Natasha! Sending you an email via this API I just made." }' http://localhost:9393/send-email

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