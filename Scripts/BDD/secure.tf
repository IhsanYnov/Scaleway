resource "scaleway_rdb_acl" "main" {
  instance_id = scaleway_rdb_instance.main.id
  acl_rules {
    ip = "51.158.110.0/24"
    description = "Autorisée"
  }
}