variable "gke_cluster_name" {
  type = string
  default = "gke-cluster-dev"
}

variable "gke_region" {
  type = string
  default = "southamerica-east1-a"
}

variable "kubernates_namespaces" {
  type    = set(string)
  default = ["nginx", "cert-manager", "monitoring"]
}

variable "google_project_id" {
  type = string
}