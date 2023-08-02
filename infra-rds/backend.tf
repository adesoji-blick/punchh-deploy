terraform {
  backend "s3" {
    bucket = "punchh-infra-backend"
    key    = "terraform-backend/rds-statefile"
    region = "ca-central-1"
  }
}