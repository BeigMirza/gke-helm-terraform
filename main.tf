provider "google" {
  project     = "gke-helm-431811"
  region      = "asia-south1"
  zone        = "asia-south1-a"
  credentials = file("gke-helm-431811-d2d2a95ce3eb.json")
}

data "google_client_config" "default" {}

provider "helm" {

    kubernetes {
            host                   = "https://${google_container_cluster.primary.endpoint}"
            token                  = data.google_client_config.default.access_token
            cluster_ca_certificate = base64decode(google_container_cluster.primary.master_auth[0].cluster_ca_certificate)
            exec {
            api_version = "client.authentication.k8s.io/v1beta1"
            command     = "gke-gcloud-auth-plugin"
            }
    }
}