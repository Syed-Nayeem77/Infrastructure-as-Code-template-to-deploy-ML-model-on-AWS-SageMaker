import xgboost
import json
import os
import joblib
import numpy as np

model = None

def model_fn(model_dir):
    global model
    model_path = os.path.join(model_dir, "xgboost-model.bin")
    model = xgboost.Booster()
    model.load_model(model_path)
    return model

def input_fn(request_body, request_content_type):
    if request_content_type == 'application/json':
        input_data = json.loads(request_body)
        return np.array(input_data['data'])
    raise ValueError("Unsupported content type")

def predict_fn(input_data, model):
    dmatrix = xgboost.DMatrix(input_data)
    return model.predict(dmatrix)

def output_fn(prediction, content_type):
    return json.dumps(prediction.tolist())
