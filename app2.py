from flask import Flask, request
import os
import sys

app = Flask(__name__)

@app.route('/')
def home():
    return "Hello from Flask App 2!"

@app.route('/health')
def health():
    return "OK"

# Новий POST ендпоінт для симуляції аварійного завершення
@app.route('/sysexc1', methods=['POST'])
def crash():
    # Це навмисно завершить процес з кодом 1
    sys.exit(1)
    return "This will never be returned"

if __name__ == '__main__':
    port = int(os.environ.get('PORT', 5000))
    app.run(host='0.0.0.0', port=port)

