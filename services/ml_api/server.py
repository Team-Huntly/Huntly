from flask import Flask, request, jsonify  
from service import cluster_texts

app = Flask(__name__)

@app.route('/')

def index():
    return 'endpoint is at /service'


@app.route('/service', methods=['POST'])
def service():
    data = request.get_json()
    bios = data['bios']
    size = data['size']
    clusters = cluster_texts(bios, size)
    clusters = {int(k) : v for k, v in clusters.items()}
    try:
        return jsonify(clusters)
    except Exception as e:
        return jsonify({'error': str(e)})
      
if __name__ == '__main__':
    app.run(debug=True, host='0.0.0.0')