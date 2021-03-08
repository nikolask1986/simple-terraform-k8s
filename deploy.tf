#Create Cluster
resource "digitalocean_kubernetes_cluster" "test" {
  name   = "test"
  region = "lon1"
  # Grab the latest version of Kubernetes using "doctl kubernetes options versions"
  version = "1.20.2-do.0"

  node_pool {
    name       = "worker-pool"
    size       = "s-2vcpu-2gb"
    node_count = 2
  }
}

#Output the cluster id
output "cluster-id" {
  value = digitalocean_kubernetes_cluster.test.id
}

#Output the cluster ip
output "cluster-ip" {
  value = digitalocean_kubernetes_cluster.test.ipv4_address
}

#Output the cluster kubeconfig if connection to the server is required
output "cluster-kubeconfig" {
  value = digitalocean_kubernetes_cluster.test.kube_config.0.raw_config
}

#Connect to kubetcl
provider "kubectl" {
  host                   = digitalocean_kubernetes_cluster.test.kube_config.0.host
  cluster_ca_certificate = base64decode(digitalocean_kubernetes_cluster.test.kube_config.0.cluster_ca_certificate)
  token                  = digitalocean_kubernetes_cluster.test.kube_config.0.token
  load_config_file       = false
}

#Find the manifests
data "kubectl_path_documents" "manifests" {
    pattern = "./manifests/*.yml"
}

#Apply the manifests
resource "kubectl_manifest" "test" {
    count     = length(data.kubectl_path_documents.manifests.documents)
    yaml_body = element(data.kubectl_path_documents.manifests.documents, count.index)
}