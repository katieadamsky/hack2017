from google.cloud import language
from google.cloud.language import enums
from google.cloud.language import types

import sys

# Instantiates a client
client = language.LanguageServiceClient()
def SentimentAnalysis(text):
    # The text to analyze
    document = types.Document(
        content=text,
        type=enums.Document.Type.PLAIN_TEXT)

    # Detects the sentiment of the text
    sentiment = client.analyze_sentiment(document=document).document_sentiment

    sentimentScore = sentiment.score

    return sentimentScore

text = sys.argv[1]

print SentimentAnalysis(text)
