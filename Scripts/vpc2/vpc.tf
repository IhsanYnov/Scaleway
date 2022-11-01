resource scaleway_vpc_private_network pn02 {
    name = "reseau1"
}

resource "scaleway_instance_server" "base1" {
  image = "ubuntu_jammy"
  type  = "DEV1-S"
  name="deb2"

  private_network {
    pn_id = scaleway_vpc_private_network.pn02.id
  }
  
  
}


resource "scaleway_instance_server" "base2" {
  image = "ubuntu_jammy"
  type  = "DEV1-S"
  name="deb1"

  private_network {
    pn_id = scaleway_vpc_private_network.pn02.id
  }
  
  
}