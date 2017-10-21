require 'twitter'
require 'nokogiri'

# Load api info from xml file
file = File.read("twitter_key.xml")
xml = Nokogiri::XML(file)
config = {
  consumer_key:    xml.xpath("//key").text,
  consumer_secret: xml.xpath("//secret").text,
}

# Set up api client
client = Twitter::REST::Client.new(config)

# Query
