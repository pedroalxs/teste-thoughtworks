# Configuração do provedor GCP
variable "region" {
  default = "us-central1"
}

variable "project" {
  description = "ID do Projeto GCP"
}

provider "google" {
  project     = var.project
  region      = var.region
  credentials = "../.interviewee-creds.json"
}

# Configuração do backend do Terraform usando o Google Cloud Storage (GCS)
terraform {
  backend "gcs" {
    prefix      = "base"
    credentials = "../.interviewee-creds.json"
  }
}