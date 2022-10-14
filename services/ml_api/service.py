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
    """ Tokenize text and stem words removing punctuation
    #Params:
    text: string
    stem: boolean
    """

    text = text.translate(str.maketrans('','',string.punctuation))
    tokens = word_tokenize(text)
 
    if stem:
        stemmer = PorterStemmer()
        tokens = [stemmer.stem(t) for t in tokens]
 
    return tokens
 
 
def model_generator(texts):
    """ Transform texts to Tf-Idf coordinates
    #Params:
    texts: list of strings

    """
    vectorizer = TfidfVectorizer(tokenizer=process_text,
                                 stop_words=stopwords.words('english'),
                                 max_df=0.5,
                                 min_df=0.1,
                                 lowercase=True)
 
    tfidf_model = vectorizer.fit_transform(texts)
    return tfidf_model
 
def optimal_k(tfidf_model, max_k):
    """ Calculate the optimal number of clusters using the sil coeff
    #Params:
    tfidf_model: Tf-Idf vector
    max_k: maximum number of clusters
    """
    from sklearn.metrics import silhouette_score
    from sklearn.cluster import KMeans
 
    sil_scores = []
    for k in range(2, max_k+1):
        km = KMeans(n_clusters=k)
        km.fit(tfidf_model)
        sil_scores.append(silhouette_score(tfidf_model, km.labels_))
    print(f"The most optimum amount of clusters is {sil_scores.index(max(sil_scores)) + 2}")
 
    return sil_scores.index(max(sil_scores)) + 2


def clusterer(tfidf_model, clusters):
    """ Cluster the model using K-Means
    #Params:
    tfidf_model: Tf-Idf vector
    clusters: number of clusters
    """
    km_model = KMeans(n_clusters=clusters)
    km_model.fit(tfidf_model)
 
    clustering = collections.defaultdict(list)
 
    for idx, label in enumerate(km_model.labels_):
        clustering[label].append(idx)
 
    return clustering

def get_even_clusters(clustering, n):
    """ Divide the clusters into n even groups 
    #Params:
    clustering: dict of clusters
    n: number of teams
    """
    random =[]
    final_cluster={}
    clusters = list(clustering.keys())
    j =0
    for i in clusters:
        if len(clustering[i])<n:
            random+=clustering[i]
        else:
            while len(clustering[i])>n:
                final_cluster[j]=clustering[i][:n]
                clustering[i]=clustering[i][n:]
                j+=1

            if len(clustering[i])>0:
              random+=clustering[i]
                
    while len(random)>n:
        final_cluster[j]=random[:n]
        random=random[n:]
        j+=1
    
    if len(random)>0:
        final_cluster[j]=random
    return final_cluster

        
def cluster_texts(texts,n):
    """ Cluster texts using K-Means 
    #Params:
    texts: list of strings
    n: number of teams
    """
    tfidf_model = model_generator(texts)
    clusters = optimal_k(tfidf_model,2*n) 
    clustering = clusterer(tfidf_model, clusters)
    clustering = get_even_clusters(clustering, n)
    return clustering
 
 
if __name__ == "__main__":
    #only for testing
    
    articles = [
        "The sky is blue and beautiful.",
        "Love this blue and beautiful sky!",
        "The quick brown fox jumps over the lazy dog.",
        "A king's breakfast has sausages, ham, bacon, eggs, toast and beans",
        "I love green eggs, ham, sausages and bacon!",
        "The brown fox is quick and the blue dog is lazy!",
        "The sky is very blue and the sky is very beautiful today",
        "The dog is lazy but the brown fox is quick!"
    ]
    clusters = clusterer(articles, 3)
    print(dict(clusters))