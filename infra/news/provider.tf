# Definir variáveis para o provedor GCP
variable "region" {
  default = "us-central1"
}

variable "project" {
  description = "ID do Projeto GCP"
}

# Configurar o provedor GCP
provider "google" {
  project     = var.project
  region      = var.region
  credentials = "../.interviewee-creds.json"
}

# Configurar o backend do Terraform para armazenamento remoto usando o Google Cloud Storage (GCS)
terraform {
  backend "gcs" {
    prefix      = "news"
    credentials = "../.interviewee-creds.json"
  }
}
