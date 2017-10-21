def get_sentiment(tweets)
  result = []
  tweets.each do |tweet|
    result.push({tweet => `python #{Rails.root.join('app', 'Sentiment.py')} '#{tweet}'`})
    #result.push(`python #{Rails.root.join('app', 'Sentiment.py')} '#{tweet}'`)
  end
  return result
end
