
 
 resource "scaleway_rdb_instance" "main" {
 
  name           = "ihsan-db"
  node_type      = "DB-DEV-S"
  engine         = "MySQL-8"
  is_ha_cluster  = true

  user_name      = "ihsan"
  password       = "N@thandu66"
 
  

}
