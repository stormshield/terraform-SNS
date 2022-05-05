/*
 * security group
 */

resource "outscale_security_group" "ha_sg" {
  description = "HA security group"
  net_id      = var.vpc_id
  tags {
    key   = "name"
    value = "${var.project_name}_sg"
  }
}

/*

TODO list port for HA...

resource "outscale_security_group_rule" "ha_sg_rule_ssh" {
  flow              = "Inbound"
  security_group_id = outscale_security_group.ha_sg.id
  from_port_range   = "22"
  to_port_range     = "22"
  ip_protocol       = "tcp"
  ip_range          = "0.0.0.0/0"
}

resource "outscale_security_group_rule" "ha_sg_rule_sshrdr" {
  flow              = "Inbound"
  security_group_id = outscale_security_group.ha_sg.id
  from_port_range   = "2222"
  to_port_range     = "2222"
  ip_protocol       = "tcp"
  ip_range          = "0.0.0.0/0"
}


resource "outscale_security_group_rule" "ha_sg_rule_https" {
  flow              = "Inbound"
  security_group_id = outscale_security_group.ha_sg.id
  from_port_range   = "443"
  to_port_range     = "443"
  ip_protocol       = "tcp"
  ip_range          = "0.0.0.0/0"
}
*/

resource "outscale_security_group_rule" "ha_sg_rule_passall" {
  flow              = "Inbound"
  security_group_id = outscale_security_group.ha_sg.id
  ip_protocol       = "-1"
  ip_range          = "0.0.0.0/0"
}

