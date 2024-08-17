resource "helm_release" "promtest" {
  name       = "prometheus"
  repository = "https://prometheus-community.github.io/helm-charts"
  chart      = "prometheus"
  version    = "25.25.0"
  values = [
    "${file("values-prometheus.yaml")}"
  ]
  depends_on = [
    google_container_node_pool.primary_preemptible_nodes
  ]
}
resource "helm_release" "grafanaexample" {
  name       = "my-local-release"
  repository = "./custom_chart_grafana/"
  chart      = "grafana"  # This should match the name of the chart in the `.tgz` file
  version    = "8.4.1"  # Ensure this matches the version of the packaged chart
  depends_on = [
    helm_release.promtest
  ]
}

resource "helm_release" "blackbox" {
  name       = "prometheus-blackbox-exporter"
  repository = "https://prometheus-community.github.io/helm-charts"
  chart      = "prometheus-blackbox-exporter"
  version    = "9.0.0"
  depends_on = [
    helm_release.promtest
  ]
}

resource "helm_release" "pingapi" {
  name       = "pingpongapi"
  repository = "./custom_chart_pingApi/"
  chart      = "pingapi"  # This should match the name of the chart in the `.tgz` file
  version    = "0.1.0"  # Ensure this matches the version of the packaged chart
  depends_on = [
    helm_release.promtest
  ]
}
resource "helm_release" "pingreq" {
  name       = "pingreq"
  repository = "./custom_chart_pingApi/"
  chart      = "pingreq"  # This should match the name of the chart in the `.tgz` file
  version    = "0.1.0"  # Ensure this matches the version of the packaged chart
  depends_on = [
    helm_release.promtest
  ]
}