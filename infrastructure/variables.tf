# Variáveis do Cloud Storage (bucket)
variable "project_id" {
  description = "O ID do projeto Google Cloud."
  type        = string
}

variable "bucket_name" {
  description = "O nome único do bucket do Cloud Storage."
  type        = string
}

variable "location" {
  description = "A localização do bucket (ex: US, EUROPE-WEST1)."
  type        = string
  default     = "EUROPE-WEST1"
}

variable "storage_class" {
  description = "A classe de armazenamento do bucket (ex: STANDARD, NEARLINE, COLDLINE, ARCHIVE)."
  type        = string
  default     = "STANDARD"
}

variable "uniform_bucket_level_access" {
  description = "Ativar o acesso uniforme no nível do bucket."
  type        = bool
  default     = true
}


# Varriáveis do Dataproc
variable "dataproc_cluster_name" {
  description = "O nome do cluster do Dataproc."
  type        = string
}

variable "dataproc_region" {
  description = "A região onde o cluster do Dataproc será provisionado."
  type        = string
  default     = "europe-west1" # Exemplo: defina uma região mais próxima se necessário
}

variable "dataproc_zone" {
  description = "A zona onde o cluster do Dataproc será provisionado (dentro da região)."
  type        = string
  default     = "europe-west1-b" # Exemplo: defina uma zona dentro da sua região
}

variable "dataproc_image_version" {
  description = "A versão da imagem do Dataproc (ex: 2.1-debian11, 2.0-debian10)."
  type        = string
  default     = "2.1-debian11"
}

variable "master_machine_type" {
  description = "Tipo de máquina para os nós mestres do Dataproc."
  type        = string
  default     = "e2-standard-2"
}

variable "worker_machine_type" {
  description = "Tipo de máquina para os nós de worker do Dataproc."
  type        = string
  default     = "e2-standard-2"
}

variable "num_workers" {
  description = "Número de nós de worker no cluster."
  type        = number
  default     = 2
}

variable "num_preemptible_workers" {
  description = "Número de nós de worker preemptivos (spot) no cluster."
  type        = number
  default     = 0 # Comece com 0 para estabilidade, adicione para economia
}