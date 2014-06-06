new_relic_challenge
===================

Create an API endpoint that sends an email when someone submits a POST request with JSON content.

Here's a sample cURL request that sends an email based on the JSON payload.

curl -X POST -H "Content-Type: application/json" -d '{ "to": "Brantley <test@gmail.com>", "subject": "Hello World!", "body": "Hi World! Sending you an email via this API I just made." }' http://localhost:9393/send-email
