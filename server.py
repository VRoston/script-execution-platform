from flask import Flask, jsonify
import subprocess

app = Flask(__name__)

@app.route('/run-script', methods=['GET'])
def run_script():
    try:
        # Executa o script e captura a saída
        result = subprocess.run(['./execute.sh'], capture_output=True, text=True, check=True)
        return jsonify({"output": result.stdout.strip()})
    except subprocess.CalledProcessError as e:
        return jsonify({"error": e.stderr.strip()}), 500

if __name__ == '__main__':
    app.run(host='0.0.0.0', port=5000)