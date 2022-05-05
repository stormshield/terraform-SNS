
/*
 * private route table
 */

resource "outscale_route_table" "private_rt" {
  net_id = var.vpc_id
  tags {
    key   = "name"
    value = "${var.project_name}_private_rt"
  }
}

resource "outscale_route_table_link" "private_rt_link" {
  subnet_id      = var.private_subnet_id
  route_table_id = outscale_route_table.private_rt.route_table_id
}

resource "outscale_route" "private_default_route" {
  nic_id               = outscale_nic.eva1_private_nic.nic_id
  destination_ip_range = "0.0.0.0/0"
  route_table_id       = outscale_route_table.private_rt.route_table_id
}
