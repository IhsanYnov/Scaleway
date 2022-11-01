resource "scaleway_instance_ip" "public_ip" {}
  resource "scaleway_instance_volume" "data" {
    size_in_gb = 10
    type = "l_ssd"
  }
  resource "scaleway_instance_server" "my-instance" {
    type  = "DEV1-L"
    image = "debian_bullseye"

    tags = [ "terraform instance", "my-instance" ]

    ip_id = scaleway_instance_ip.public_ip.id

    additional_volume_ids = [ scaleway_instance_volume.data.id ]

    root_volume {
      # The local storage of a DEV1-S instance is 80 GB, subtract 30 GB from the additional l_ssd volume, then the root volume needs to be 50 GB.
      size_in_gb = 15
    }
	security_group_id = scaleway_instance_security_group.my-security-group.id
  }