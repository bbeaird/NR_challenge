require 'rubygems'
require 'sinatra'
require 'mandrill'
require 'action_mailer'
require 'pony'
require 'dotenv'
require 'mail'

Dotenv.load

# class MyMailer < ActionMailer::Base
#   default from: 'noreply@example.com'

#   def test_email
#     mail(to: 'bbeaird@gmail.com', subject: 'Test subject doode!!!', body: 'Sample body text!!!')
#   end
# end

# Not sure why I had to replace the colons with hashrockets??? Ahhh...it's because the keys are actually strings instead of symbols!!!
payload = { "to"=> "Natasha <natasha@newrelic.com>", "subject"=> "hello world", "body"=> "Hi Natasha! Sending you an email via this API I just made." }

get '/form' do
  erb :form
end

post '/form' do
  "You sent #{params}!!!!!!!!!!!!!!!!"
end

get '/send-email' do
  # MyMailer.test_email.deliver
  # "Check your email doode!!!"

  # Pony.mail to: 'bbeaird@gmail.com',
  #           via: 'smtp',
  #           via_options: {
  #             address: 'smtp.gmail.com',
  #             port: '587',
  #             enable_start_tls_auto: true,
  #             user_name: 'bbeaird',
  #             password: ENV['GMAIL_PASSWORD'],
  #             authentication: :plain,
  #             domain: 'localhost.localdomain'
  #           },
  #           subject: 'Howdy partner!',
  #           body: 'Big plans to celebrate after you get this job?!'

  Mail.defaults do
    delivery_method :smtp, {
      port: 587,
      address: 'smtp.mandrillapp.com',
      user_name: ENV['MANDRILL_USERNAME'],
      password: ENV['MANDRILL_PASSWORD']
    }
  end

  mail = Mail.deliver do
    to 'bbeaird@gmail.com'
    from 'Brantley Beaird <noreply@example.com>'
    subject 'Test subject doode!!!'

    text_part do
      body 'Mandrill speaks plaintext'
    end

    html_part do
      content_type 'text/html; charset=UTF-8'
      body '<em>Mandrill speaks <strong>HTML</strong></em>'
    end
  end

  'Check your email! Hopefully you received the above message!'
end

post '/send-email' do
  "You sent #{params}!!!!!!!!!!!!!!!!"
end