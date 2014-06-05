require 'rubygems'
require 'sinatra'
require 'mandrill'
require 'dotenv'
require 'mail'

Dotenv.load

# payload = { "to"=> "Natasha <natasha@newrelic.com>", "subject"=> "hello world", "body"=> "Hi Natasha! Sending you an email via this API I just made." }

payload = { "to"=> "Brantley Beaird <bbeaird@gmail.com>", "subject"=> "hello world", "body"=> "Hi Natasha! Sending you an email via this API I just made." }

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