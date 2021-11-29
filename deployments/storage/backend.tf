
terraform {
  backend "gcs" {
    bucket = "backend-resource-331609"
    prefix = "task2"
  }
}
