module "nomad" {
  source = "git::git@github.com:fuzzylabs/terraform-google-nomad.git?ref=fuzzy_fixes"

  gcp_project                      = var.gcp_project
  gcp_region                       = var.gcp_region
  gcp_zone                         = var.gcp_zone
  nomad_consul_server_cluster_name = var.nomad_consul_server_cluster_name
  nomad_consul_server_source_image = var.nomad_consul_server_source_image
  nomad_client_cluster_name        = var.nomad_client_cluster_name
  nomad_client_source_image        = var.nomad_client_source_image
}
