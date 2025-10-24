from flask import Flask, jsonify, request
from flask_cors import CORS
import subprocess
import os

app = Flask(__name__)
CORS(app)

@app.route('/run-script', methods=['POST'])
def run_script():
    try:
        data = request.get_json()
        cpu = data.get('cpu')
        cpuUsage = (data.get('cpuUsage') * 1000)
        weight = data.get('weight')
        # Monta o comando com as variáveis recebidas
        cmd = ["/vagrant/execute.sh", "execute", str(cpu), str(weight), str(cpuUsage)]
        result = subprocess.run(cmd, capture_output=True, text=True, check=True)
        return jsonify({"output": result.stdout.strip()})
    except subprocess.CalledProcessError as e:
        return jsonify({"error": e.stderr.strip()}), 500
    except Exception as e:
        return jsonify({"error": str(e)}), 500

@app.route('/save-script', methods=['POST'])
def save_script():
    try:
        data = request.get_json()
        filename = data.get('filename')
        content = data.get('content')
        # Caminho seguro para a pasta do Vagrant
        base_path = '/vagrant'
        file_path = os.path.join(base_path, filename)
        with open(file_path, 'w', encoding='utf-8') as f:
            f.write(content)
        return jsonify({"message": f"Arquivo '{filename}' salvo com sucesso."})
    except Exception as e:
        return jsonify({"error": str(e)}), 500

if __name__ == '__main__':
    app.run(host='0.0.0.0', port=5000)