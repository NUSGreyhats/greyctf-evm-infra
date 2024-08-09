from . import *
from .util import getenv_or_raise
from flask import Flask, render_template, request, jsonify
import os
import uuid

app = Flask(__name__)

# Mock backend functions
instances = {}
contract_path = getenv_or_raise("CONTRACT_PATH")
contract_value = int(os.getenv("CONTRACT_DEPLOY_VALUE", "0"))
contract_args = os.getenv("CONTRACT_DEPLOY_ARGS", "")


def launch_instance():
    return new_launch_instance_action(setup(contract_path, contract_value, contract_args)).handler()

def kill_instance(instance_id):
    return new_kill_instance_action().handler(instance_id)

def get_flag(instance_id, challenge_id):
    return new_get_flag_action().handler(instance_id, challenge_id)

@app.route('/')
def index():
    return render_template('index.html')

@app.route('/name')
def name():
    return os.getenv("CHALLENGE_NAME", "Instance Manager")

@app.route('/launch', methods=['POST'])
def launch():
    result = launch_instance()
    return jsonify(result)

@app.route('/kill', methods=['POST'])
def kill():
    instance_id = request.form['instance_id']
    result = kill_instance(instance_id)
    return jsonify({'result': result})

@app.route('/get_flag', methods=['POST'])
def flag():
    instance_id = request.form['instance_id']
    challenge_id = request.form['challenge_id']
    result = get_flag(instance_id, challenge_id)
    return jsonify({'result': result})

if __name__ == '__main__':
    app.run(host="0.0.0.0", port=os.getenv("PORT", 5000), debug=True)
