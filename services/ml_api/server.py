from flask import Flask, request, jsonify  
from service import cluster_texts 


app = Flask(__name__)

@app.route('/')
def index():
    return 'Hello World'
