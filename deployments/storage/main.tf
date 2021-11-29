provider "google" {

}
module "gcs_buckets" {
  source = "../../modules/storage"
  #version = "~> 2.2"
  project_id = var.project_id
  names      = ["first", "second"]
  prefix     = "terraform-created"
  versioning = {
    enabled = true
  }
  lifecycle_rules = [

    { condition = {
      age = 1
      }
      action = {
        type          = "SetStorageClass"
        storage_class = "COLDLINE"
      }
    },
    { condition = {
      age = 5
      }
      action = {
        type                  = "SetStorageClass"
        storage_class         = "NEARLINE",
        matches_storage_class = "COLDLINE"
      }
    }

  ]
}
