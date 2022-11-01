resource "scaleway_vpc_public_gateway" "main" {
    name = "public_gateway_demo"
    type = "VPC-GW-S"
    tags = ["demo", "terraform"]
	project_id ="f8f64f6d-0933-4758-be35-c07395306199"
	
	
	
}