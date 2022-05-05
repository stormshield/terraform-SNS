resource "outscale_vm" "server_vm" {
  image_id           = var.ubuntu_omi
  vm_type            = var.ubuntu_vm_type
  keypair_name       = var.keypair
  security_group_ids = [outscale_security_group.ha_sg.security_group_id]
  subnet_id          = outscale_subnet.private_subnet.subnet_id
  private_ips        = [var.server_ip]

  tags {
    key   = "name"
    value = "${var.project_name}_server"
  }

}