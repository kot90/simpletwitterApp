require 'open-uri'
require 'rubygems'
require 'oauth'
require 'json'

#created with the help of codecademy

puts "Enter the text of your tweet"

tweet_to_send = gets.chomp 

#check that user input is not greater than 140 characters
if(tweet_to_send.length > 140)
	{
		put "Tweet was longer than 140 characters, shortening..."
		tweet_to_send = tweet_to_send[0,140]
	}
end

# Add your keys here to enable program to function correctly
consumer_key = OAuth::Consumer.new(
    "wqChJR3rUyO7vVRecQ",
    "ia5ERTqtpYXaADgAm1XXK3daBp0z1TusVkFo4DHx")
  #"ia5ERTqtpYXaADgAm1XXK3daBp0z1TusVkFo4DHxA")
access_token = OAuth::Token.new(
    "300029103-cXZpXpor9nNHF3zfB8ey4YaHjpzAzq1KvFePYRdl",
    "fw0oziy4V3ZNG5Alf4LiStzcBhi65XUPq8xB1OiMmV3rC")


#set up correct path for update
baseurl = "https://api.twitter.com"
path    = "/1.1/statuses/update.json"
address = URI("#{baseurl}#{path}")
request = Net::HTTP::Post.new address.request_uri
request.set_form_data(
  "status" => tweet_to_send,
)

# Set up HTTP.
http             = Net::HTTP.new address.host, address.port
http.use_ssl     = true
http.verify_mode = OpenSSL::SSL::VERIFY_PEER


# Issue the request.
request.oauth! http, consumer_key, access_token
http.start
response = http.request request

# Parse and print the Tweet if the response code was 200
tweet = nil
if response.code == '200' then
  tweet = JSON.parse(response.body)
  puts "Successfully sent: #{tweet["text"]}"
  #print_tweet(tweet)
else 
	puts "Could not send tweet; returned with response code #{response.code}"
	#print response.code
end
