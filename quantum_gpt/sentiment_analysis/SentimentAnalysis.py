import spacy
from transformers import pipeline

class User:
    def __init__(self, name, credibility):
        self.name = name
        self.credibility = credibility

# Initialize spaCy and the sentiment analyzer with a specific model
nlp = spacy.load("en_core_web_sm")
sentiment_analyzer = pipeline("sentiment-analysis", model="distilbert-base-uncased-finetuned-sst-2-english")

def analyze_sentiment(comment):
    result = sentiment_analyzer(comment)[0]
    sentiment_label = 'positive' if result['label'] == 'POSITIVE' else 'negative'
    sentiment_score = result['score']

    # Named Entity Recognition
    doc = nlp(comment)
    entities = [(ent.text, ent.label_) for ent in doc.ents]

    return sentiment_label, sentiment_score, entities

def adjust_credibility(user, sentiment, score, commenter_credibility):
    # Increase credibility for positive comments from credible users
    if sentiment == 'positive' and commenter_credibility > 0.5:
        adjustment = score * 0.1  # dynamic adjustment based on sentiment score
        user.credibility = min(user.credibility + adjustment, 1)

def process_comments(user_a, user_b, comment_a):
    sentiment, score, entities = analyze_sentiment(comment_a)
    adjust_credibility(user_b, sentiment, score, user_a.credibility)
    return entities

# Example usage
user_a = User("Alice", 0.7)
user_b = User("Bob", 0.3)

comment_a = "I really appreciate your insightful thoughts on the latest NASA mission!"
entities = process_comments(user_a, user_b, comment_a)

print(f"User B's new credibility: {user_b.credibility}")