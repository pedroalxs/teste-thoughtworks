# Configuração do registro de contêineres no Google Cloud
resource "google_container_registry" "registry" {
  project  = var.project
  location = "EU"
}

# Obtenção de informações sobre o repositório no registro de contêineres
data "google_container_registry_repository" "repository" {
}

# Conceder permissões ao usuário padrão de instância de computação para ler do GCR
data "google_compute_default_service_account" "default" {}

resource "google_storage_bucket_iam_member" "viewer" {
  bucket = google_container_registry.registry.id
  role   = "roles/storage.admin"
  member = "serviceAccount:${data.google_compute_default_service_account.default.email}"
}

# Definir variável local para a URL do repositório no GCR
locals {
  gcr_url = data.google_container_registry_repository.repository.repository_url
}

# Criar um arquivo local contendo a URL do repositório
resource "local_file" "gcr" {
  filename = "${path.module}/../gcr-url.txt"
  content  = local.gcr_url
}

# Exibir a URL base do repositório como saída
output "repository_base_url" {
  value = local.gcr_url
}
