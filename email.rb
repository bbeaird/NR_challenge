require 'rubygems'
require 'sinatra'
require 'mandrill'
require 'action_mailer'
require 'pony'
require 'dotenv'

Dotenv.load

class MyMailer < ActionMailer::Base
  default from: 'noreply@example.com'

  def test_email
    mail(to: 'bbeaird@gmail.com', subject: 'Test subject doode!!!')
  end
end

# Not sure why I had to replace the colons with hashrockets??? Ahhh...it's because the keys are actually strings instead of symbols!!!
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
  # MyMailer.test_email.deliver
  # "Check your email doode!!!"
  Pony.mail to: 'bbeaird@gmail.com',
            via: 'smtp',
            via_options: {
              address: 'smtp.gmail.com',
              port: '587',
              enable_start_tls_auto: true,
              user_name: 'bbeaird@gmail.com',
              password: ENV['GMAIL_PASSWORD'],
              authentication: :plain,
              domain: 'localhost.localdomain'
            },
            # from: 'bbeaird@gmail.com',
            subject: 'Howdy partner!',
            body: 'Big plans to celebrate after you get this job?!'

  'Check your email! Hopefully you received the above message!'
end

post '/send-email' do
  # "You sent !!!!!!!!!!!!!!!!!!!!"
  "You sent #{params}!!!!!!!!!!!!!!!!"
end