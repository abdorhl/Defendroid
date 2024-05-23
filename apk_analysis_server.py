import pickle
from flask import Flask, request, jsonify
import os
import uuid  # for generating unique filenames
import zipfile  # for handling zip archives (APK format)
from androguard.misc import AnalyzeAPK
import numpy as np
import tensorflow as tf

app = Flask(__name__)

model = tf.lite.Interpreter(model_path="assets/model/model.tflite")
model.allocate_tensors()

features = pickle.loads(open('classifier/features.pkl', 'rb').read())

@app.route('/analyze_apk', methods=['POST'])
def analyze_apk():
    if request.method != 'POST':
        return jsonify({'error': 'Method not allowed'}), 405

    if 'Content-Type' not in request.headers or \
            not request.headers['Content-Type'].startswith('multipart/form-data'):
        return jsonify({'error': 'Invalid content type'}), 400

    try:
        print("Request received:", request.files)

        if 'apk' not in request.files:
            return jsonify({"error": "APK file not found in request"})

        apk_file = request.files['apk']
        apk_file_path = save_apk_file(apk_file)

        if apk_file_path is None:
            return jsonify({"error": "Failed to save APK file"})

        # Log the file path where the APK file is saved
        print("APK file saved to:", apk_file_path)

        # Analyze the APK file
        apk_analysis = analyze_apk_file(apk_file_path)

        # Respond with the analysis result
        return jsonify(apk_analysis)

    except Exception as e:
        if isinstance(e, OSError):
            print(f"Error saving APK file: {e}")
            return jsonify({"error": "Error saving APK file"})
        elif isinstance(e, PermissionError):
            print(f"Permission error: {e}")
            return jsonify({"error": "Insufficient permissions to save file"})
        else:
            print(f"Unexpected error: {e}")
            return jsonify({"error": "Internal server error"})

def save_apk_file(apk_file):
    try:
        # Create the /tmp directory if it does not exist
        tmp_dir = '/tmp'
        if not os.path.exists(tmp_dir):
            os.makedirs(tmp_dir)

        filename, file_extension = os.path.splitext(apk_file.filename)
        unique_filename = f"{filename}_{uuid.uuid4()}{file_extension}"
        apk_file_path = os.path.join(tmp_dir, unique_filename)
        apk_file.save(apk_file_path)
        return apk_file_path
    except Exception as e:
        print(f"Error saving APK file: {e}")
        return None

def analyze_apk_file(apk_file_path):
    try:
        a, d, dx = AnalyzeAPK(apk_file_path)
        permissions = a.get_permissions()

        # Initialize the feature vector
        res = [0] * len(features)
        
        # Debug: Print the permissions and features
        print(f"Permissions: {permissions}")
        print(f"Features: {features}")

        # Ensure feature names are strings
        feature_indices = {feature: idx for idx, feature in enumerate(features)}

        # Map permissions to the feature vector
        for permission in permissions:
            if permission in feature_indices:
                res[feature_indices[permission]] = 1

        # Predict the result based on the feature vector
        prediction = predict(res)
        return prediction
    except Exception as e:
        return {"error": str(e)}

def predict(features):
    input_details = model.get_input_details()
    output_details = model.get_output_details()

    input_shape = input_details[0]['shape']
    input_data = np.array(features, dtype=np.float32).reshape(input_shape)

    model.set_tensor(input_details[0]['index'], input_data)
    model.invoke()

    output_data = model.get_tensor(output_details[0]['index'])
    prediction = output_data[0]

    return "malicious" if prediction > 0.6 else "not malicious"

if __name__ == '__main__':
    app.run(host='0.0.0.0', port=8000)
