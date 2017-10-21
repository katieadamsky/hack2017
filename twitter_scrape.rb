require 'twitter'
require 'nokogiri'
require 'net/http'

# Load api info from xml file
file = File.read("twitter_key.xml")
xml = Nokogiri::XML(file)
config = {
  consumer_key: xml.xpath("//key").text,
  consumer_secret: xml.xpath("//secret").text,
}

# Set up api client
client = Twitter::REST::Client.new(config)

# Query
user = 'realDonaldTrump'
options = {count: 5, include_rts: false}
tweets = client.user_timeline(user, options)
tweets.each do |tweet|
  puts "Tweet"
  puts tweet.full_text
  puts ""
end
