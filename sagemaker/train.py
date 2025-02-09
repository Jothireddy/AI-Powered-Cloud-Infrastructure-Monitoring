import argparse
import os
import pandas as pd
from sklearn.ensemble import IsolationForest
import joblib

def main(args):
    # For example purposes, read a CSV file of log features from S3 or local disk.
    # In production, you might integrate with CloudWatch Logs export.
    data = pd.read_csv(args.input_data)
    
    # Train an Isolation Forest model for anomaly detection
    model = IsolationForest(contamination=0.01, random_state=42)
    model.fit(data)
    
    # Save the trained model
    joblib.dump(model, args.model_output)
    print(f"Model trained and saved to {args.model_output}")

if __name__ == "__main__":
    parser = argparse.ArgumentParser()
    parser.add_argument("--input_data", type=str, default="logs.csv", help="Path to training data CSV")
    parser.add_argument("--model_output", type=str, default="model.joblib", help="Path to save the trained model")
    args = parser.parse_args()
    main(args)
