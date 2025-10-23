from flask import Flask, jsonify, request
import subprocess

app = Flask(__name__)

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

if __name__ == '__main__':
    app.run(host='0.0.0.0', port=5000)