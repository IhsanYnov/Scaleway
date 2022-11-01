resource scaleway_vpc_private_network pn01 {
    name = "reseauprive1"
}

resource "scaleway_instance_server" "base" {
  image = "ubuntu_jammy"
  type  = "DEV1-S"
  name="serveur1"
 

  private_network {
    pn_id = scaleway_vpc_private_network.pn01.id
  }
}