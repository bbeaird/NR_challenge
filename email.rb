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
  # result = mandrill.users.info
  message = {"html"=>"<p>Example HTML content. Ahhhhhhhhhhhhhhhh!!!!!!!!</p>",
     "text"=>"Example text content. Hello world!!!!!",
     "subject"=>"example subject dude!!!",
     "from_email"=>"app25992133@heroku.com",
     "from_name"=>"Mandrill BIATCH!",
     "to"=>
        [{"email"=>"bbeaird@gmail.com",
            "name"=>"Brantley Beaird",
            "type"=>"to"}],
     "headers"=>{"Reply-To"=>"app25992133@heroku.com"},
     "important"=>false,
     "track_opens"=>nil,
     "track_clicks"=>nil,
     "auto_text"=>nil,
     "auto_html"=>nil,
     "inline_css"=>nil,
     "url_strip_qs"=>nil,
     "preserve_recipients"=>nil,
     "view_content_link"=>nil,
     "bcc_address"=>"message.bcc_address@example.com",
     "tracking_domain"=>nil,
     "signing_domain"=>nil,
     "return_path_domain"=>nil,
     "merge"=>true,
     "global_merge_vars"=>[{"name"=>"merge1", "content"=>"merge1 content"}],
     "merge_vars"=>
        [{"rcpt"=>"recipient.email@example.com",
            "vars"=>[{"name"=>"merge2", "content"=>"merge2 content"}]}],
     "tags"=>["password-resets"],
     "subaccount"=>"customer-123",
     "google_analytics_domains"=>["example.com"],
     "google_analytics_campaign"=>"message.from_email@example.com",
     "metadata"=>{"website"=>"www.example.com"},
     "recipient_metadata"=>
        [{"rcpt"=>"recipient.email@example.com", "values"=>{"user_id"=>123456}}],
     "attachments"=>
        [{"type"=>"text/plain",
            "name"=>"myfile.txt",
            "content"=>"ZXhhbXBsZSBmaWxl"}],
     "images"=>
        [{"type"=>"image/png", "name"=>"IMAGECID", "content"=>"ZXhhbXBsZSBmaWxl"}]}
    async = false
    ip_pool = "Main Pool"
    # send_at = "2010-01-01 01:00:00"
    send_at = Time.now
    result = mandrill.messages.send message, async, ip_pool
    "Done bitch!"
end

post '/send-email' do
  # "You sent !!!!!!!!!!!!!!!!!!!!"
  "You sent #{params}!!!!!!!!!!!!!!!!"
end