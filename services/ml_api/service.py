import string
import collections
import nltk
from nltk import word_tokenize
from nltk.stem import PorterStemmer
from nltk.corpus import stopwords
from sklearn.cluster import KMeans
from sklearn.feature_extraction.text import TfidfVectorizer
nltk.download('stopwords') 
nltk.download('punkt')

def process_text(text, stem=True):
    '''
    Tokenize text and stem words removing punctuation
    '''
    text = text.translate(str.maketrans('','',string.punctuation))
    tokens = word_tokenize(text)
 
    if stem:
        stemmer = PorterStemmer()
        tokens = [stemmer.stem(t) for t in tokens]
 
    return tokens
 
def cluster_texts(texts, clusters=3):
    '''
    Transform texts to Tf-Idf coordinates and cluster texts using K-Means
    '''
    vectorizer = TfidfVectorizer(tokenizer=process_text,
                                 stop_words=stopwords.words('english'),
                                 max_df=0.5,
                                 min_df=0.1,
                                 lowercase=True)
 
    tfidf_model = vectorizer.fit_transform(texts)
    km_model = KMeans(n_clusters=clusters)
    km_model.fit(tfidf_model)
 
    clustering = collections.defaultdict(list)
 
    for idx, label in enumerate(km_model.labels_):
        clustering[label].append(idx)
 
    return clustering
 
 
if __name__ == "__main__":
    #only for testing
    articles = [
        "i LIKE WATCHING MOVIES and series from hbo",
        "i like watching movies",
        "I LIKE PLAYING VIDEO GAMES",
        "I like watching birds",
        "I don't like watching movies",
        "I don't like playing video games",
        "I am interested in science",
        "I am looking for an honest person",
        "I am interested in science and technology",
    ]
    clusters = cluster_texts(articles, 3)
    print(dict(clusters))