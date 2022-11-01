resource "scaleway_instance_security_group" "my-security-group" {
  inbound_default_policy  = "drop"
  outbound_default_policy = "accept"

  inbound_rule {
    action = "drop"
    port   = "22"
	ip     = "10.31.39.125"
  }

  inbound_rule {
    action = "accept"
    port   = "80"
  }

  inbound_rule {
    action = "drop"
    port   = "443"
  }
}