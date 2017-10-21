from google.cloud import language
from google.cloud.language import enums
from google.cloud.language import types

import sys

# Instantiates a client
client = language.LanguageServiceClient()

def SentimentAnalysis(tweet):

    # The text to analyze
    document = types.Document(
        content=tweet,
        type=enums.Document.Type.PLAIN_TEXT)

    # Detects the sentiment of the text
    sentiment = client.analyze_sentiment(document=document).document_sentiment

    sentimentScore = sentiment.score

    return sentimentScore



text = sys.argv[1]
print SentimentAnalysis(text)
