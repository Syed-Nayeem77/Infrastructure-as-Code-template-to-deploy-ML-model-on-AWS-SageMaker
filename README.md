IaC Template for ML Deployment (Terraform + AWS SageMaker)

This project provides a ready-to-use Infrastructure as Code (IaC) template using Terraform to deploy a machine learning model to Amazon 
SageMaker. It automates:

--> Uploading our  ML model to S3
--> Creating a SageMaker model
--> Deploying it as an endpoint

Project Structure
iac-ml-sagemaker/

??? model/
?   ??? model.tar.gz       # pre-trained model archive (e.g., XGBoost)
??? scripts/
?   ??? inference.py       # Entry point script for inference (SageMaker-                									compatible)
??? terraform/
?   ??? main.tf            # Terraform configuration for SageMaker & S3
?   ??? outputs.tf         # Output values
?   ??? provider.tf        # AWS provider & region
?   ??? variables.tf       # Input variables (bucket name, role ARN,etc.)
??? requirements.txt       # Python dependencies
??? README.md              # Project documentation

Prerequisites
* AWS Account with SageMaker permissions
* An IAM Role with AmazonSageMakerFullAccess, AmazonS3FullAccess
* Terraform installed (? v1.3)
* AWS CLI configured with your credentials:
* aws configure

 Model Artifacts
--> model.tar.gz inside the model/ folder should contain:
    --> Serialized model file (e.g., xgboost-model)
    --> Optional: code/inference.py script

If we are using XGBoost:

model/
??? model.tar.gz
    ??? xgboost-model
    ??? code/
        ??? inference.py
How to Use

1. Set AWS Credentials
export AWS_ACCESS_KEY_ID=your_key
export AWS_SECRET_ACCESS_KEY=your_secret

2. Initialize Terraform
cd terraform
terraform init

3. Apply Terraform to Deploy Model
terraform apply \
  -var="s3_bucket=your-unique-s3-bucket-name" \
  -var="model_name=my-xgb-model" \
  -var="execution_role_arn=arn:aws:iam::xxxx:role/your-sagemaker-execution-role"

4. Output
--> A deployed SageMaker model
--> (Optional) Endpoint configuration

Clean Up
terraform destroy


Sample Model Support

You can use any of the following:
--> XGBoost
--> Scikit-Learn
--> PyTorch
--> TensorFlow
(Ensure your inference.py and model serialization matches)

Notes

--> Use unique bucket names as S3 buckets are global.
--> Make sure our model artifact and inference script are inside the .tar.gz archive and follow SageMaker inference container structure.

