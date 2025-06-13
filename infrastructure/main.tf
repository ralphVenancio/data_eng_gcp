# main.tf
provider "google" {
  project = var.project_id
}

resource "google_storage_bucket" this {
  name                        = var.bucket_name
  location                    = var.location
  storage_class               = var.storage_class
  uniform_bucket_level_access = var.uniform_bucket_level_access
  force_destroy               = false # Defina como true com CUIDADO!
                                      # Se for true, o bucket e TODO o seu conteúdo
                                      # serão deletados ao executar terraform destroy.
  # É possível adicionar outras configurações opcionais aqui, como:
  # versioning {
  #   enabled = true
  # }
  #
  # lifecycle_rule {
  #   action {
  #     type = "Delete"
  #   }
  #   condition {
  #     age = 365 # Deleta objetos após 365 dias
  #   }
  # }
  #
  # labels = {
  #   environment = "development"
  #   owner       = "my-team"
  # }
}

output "bucket_self_link" {
  description = "O self_link do bucket do Cloud Storage."
  value       = google_storage_bucket.this.self_link
}

# ... Configurações para o Cluster Dataproc ...

resource "google_dataproc_cluster" this {
  name    = var.dataproc_cluster_name
  region  = var.dataproc_region
  project = var.project_id # Reutiliza a variável project_id

  cluster_config {
    gce_cluster_config {
      zone        = var.dataproc_zone
      # Opcional: Adicione etiquetas de rede se seu projeto usar VPC compartilhada ou regras de firewall específicas
      # network     = "default" # ou o nome da sua rede VPC
      # subnetwork  = "default" # ou o nome da sua sub-rede
      # internal_ip_only = true # Se não precisar de IPs externos
    }

    master_config {
      num_instances  = 1 # Clusters Dataproc geralmente têm 1 master
      machine_type   = var.master_machine_type
      disk_config {
        boot_disk_type    = "pd-ssd"
        boot_disk_size_gb = 50 # Tamanho do disco de boot para o master
      }
    }

    worker_config {
      num_instances = var.num_workers
      machine_type  = var.worker_machine_type
      disk_config {
        boot_disk_type    = "pd-ssd"
        boot_disk_size_gb = 50 # Tamanho do disco de boot para os workers
      }
    }

    software_config {
      image_version = var.dataproc_image_version
      # Opcional: Adicionar componentes ou propriedades do cluster
      # properties = {
      #   "dataproc:dataproc.allow.prioritized.preemption" = "true"
      # }
      # optional_components = ["ANACONDA", "JUPYTER"]
    }

    # Opcional: Configurações de logging
    # logging_config {
    #   driver_log_levels = {
    #     "root" = "INFO"
    #   }
    # }

    # Opcional: Configurações de alta disponibilidade (se for um cluster de alta disponibilidade)
    # gce_cluster_config {
    #   service_account_scopes = [
    #     "https://www.googleapis.com/auth/cloud-platform"
    #   ]
    # }
  }

  # Opcional: Automação da exclusão (use com cautela em produção)
  # deletion_protection = false
}

output "dataproc_cluster_name" {
  description = "O nome do cluster do Dataproc."
  value       = google_dataproc_cluster.this.name
}
