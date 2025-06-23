resource "aws_s3_bucket_object" "model" {
  bucket = var.s3_bucket
  key    = "model/model.tar.gz"
  source = "../model/model.tar.gz"
}

resource "aws_sagemaker_model" "ml_model" {
  name               = var.model_name
  execution_role_arn = var.execution_role_arn

  primary_container {
    image          = "683313688378.dkr.ecr.us-west-2.amazonaws.com/sagemaker-xgboost:1.3-1"
    model_data_url = "s3://${var.s3_bucket}/model/model.tar.gz"

    environment = {
      SAGEMAKER_PROGRAM = "inference.py"
      SAGEMAKER_SUBMIT_DIRECTORY = "s3://${var.s3_bucket}/model/model.tar.gz"
    }
  }
}
