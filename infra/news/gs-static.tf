# Define um bucket de armazenamento no Google Cloud Storage
resource "google_storage_bucket" "news" {
  name          = "${var.project}-infra-static-pages"
  force_destroy = true

  # Habilita o acesso uniforme a nível de bucket
  uniform_bucket_level_access = true

  # Configuração do website estático
  website {
    main_page_suffix = "index.html"
    not_found_page   = "error.html"
  }
}

# Define as permissões para o bucket
resource "google_storage_bucket_iam_binding" "news" {
  bucket = google_storage_bucket.news.name
  role   = "roles/storage.objectViewer"

  # Permite acesso a todos os usuários (público)
  members = [
    "allUsers"
  ]
}
