/*
 * Cluster public IP
 */

resource "outscale_public_ip" "eip_ha" {
  tags {
    key   = "name"
    value = "${var.project_name}_cluster_eip"
  }
}

resource "outscale_public_ip_link" "eip_ha_link" {
  public_ip  = outscale_public_ip.eip_ha.public_ip
  nic_id     = outscale_nic.eva1_public_nic.nic_id
  private_ip = var.eva1_public_ip
}

/*
 * eva2 temporary public ip
 */

resource "outscale_public_ip" "eip_eva2" {
  tags {
    key   = "name"
    value = "${var.project_name}_EVA2_temp_eip"
  }
}

resource "outscale_public_ip_link" "eip_eva2_link" {
  public_ip = outscale_public_ip.eip_eva2.public_ip
  nic_id    = outscale_nic.eva2_public_nic.nic_id
}
