from flask import Flask, request, jsonify
from tensorflow.keras.models import load_model
from tensorflow.keras.preprocessing import image
import numpy as np
import base64  # For decoding image data from request

app = Flask(__name__)

# Model and class names (assuming you have these defined)
model = load_model("RS50_80_20_T1.h5")
class_names = ['CNV', 'DME', 'DRUSEN', 'NORMAL']


@app.route("/classify", methods=["POST"])
def classify_image():
    # Get image data from request body
    image_data = request.data

    # Decode base64 encoded image data (assuming data is sent this way)
    try:
        decoded_data = base64.b64decode(image_data)
    except Exception as e:
        print(f"Error decoding image data: {e}")
        return jsonify({"error": "Failed to decode image data"})

    # Load image from decoded data (replace with your specific format if needed)
    img = image.load_img(io.BytesIO(decoded_data), target_size=(256, 256))  # Resize

    # Convert image to array
    img_array = image.img_to_array(img)

    # Expand dimension for batch prediction (might not be necessary for single image)
    img_batch = np.expand_dims(img_array, axis=0)

    # Normalize pixel values (assuming this is a preprocessing step for your model)
    img_preprocessed = img_batch / 255.0

    # Make prediction
    prediction = model.predict(img_preprocessed)
    predicted_class = class_names[np.argmax(prediction[0])]

    # Return JSON response with predicted class
    return jsonify({"predicted_class": predicted_class})


if __name__ == "__main__":
    app.run(debug=True)
