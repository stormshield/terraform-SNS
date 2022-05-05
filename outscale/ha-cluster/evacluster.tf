/* 
 * EVA 1
 */


resource "outscale_nic" "eva1_public_nic" {
  subnet_id          = outscale_subnet.public_subnet.subnet_id
  security_group_ids = [outscale_security_group.ha_sg.security_group_id]

  private_ips {
    is_primary = true
    private_ip = var.eva1_public_ip
  }

  tags {
    key   = "name"
    value = "${var.project_name}_eva1_public_nic"
  }
}

resource "outscale_nic" "eva1_sync_nic" {
  subnet_id          = outscale_subnet.hasync_subnet.subnet_id
  security_group_ids = [outscale_security_group.ha_sg.security_group_id]

  private_ips {
    is_primary = true
    private_ip = var.eva1_sync_ip
  }

  tags {
    key   = "name"
    value = "${var.project_name}_eva1_sync_nic"
  }
}

resource "outscale_nic" "eva1_private_nic" {
  subnet_id          = outscale_subnet.private_subnet.subnet_id
  security_group_ids = [outscale_security_group.ha_sg.security_group_id]

  private_ips {
    is_primary = true
    private_ip = var.eva1_private_ip
  }

  tags {
    key   = "name"
    value = "${var.project_name}_eva1_private_nic"
  }
}


resource "outscale_vm" "eva1" {
  image_id               = var.eva_omi
  vm_type                = var.eva_vm_type
  keypair_name           = var.keypair
  is_source_dest_checked = false

  nics {
    device_number = "0"
    nic_id        = outscale_nic.eva1_public_nic.nic_id
  }

  nics {
    nic_id        = outscale_nic.eva1_sync_nic.nic_id
    device_number = "1"
  }

  nics {
    nic_id        = outscale_nic.eva1_private_nic.nic_id
    device_number = "2"
  }

  tags {
    key   = "name"
    value = "${var.project_name}_EVA1"
  }

  # for placement on two different servers
  # https://docs.outscale.com/fr/userguide/R%C3%A9f%C3%A9rence-des-tags-user-data.html
  # check with 
  # fetch -qo - http://169.254.169.254/latest/meta-data/placement/server && echo ""
  # fetch -qo - http://169.254.169.254/latest/meta-data/placement/cluster && echo ""
  tags {
    key   = "osc.fcu.repulse_cluster"
    value = "snsha"
  }

  user_data = base64encode(
    templatefile("conf_eva.sh",
      {
        "NAME"     = "HA_EVA1"
        "WANIP"    = var.eva1_public_ip
        "SYNCIP"   = var.eva1_sync_ip
        "LANIP"    = var.eva1_private_ip
        "MASK"     = var.eva_mask
        "GWIP"     = var.gateway_ip
        "SERVERIP" = var.server_ip
        "PASSWORD" = var.eva_password
      }
    )
  )
}


/* 
 * EVA 2
 */


resource "outscale_nic" "eva2_public_nic" {
  subnet_id          = outscale_subnet.public_subnet.subnet_id
  security_group_ids = [outscale_security_group.ha_sg.security_group_id]

  private_ips {
    is_primary = true
    private_ip = var.eva2_public_ip
  }

  tags {
    key   = "name"
    value = "${var.project_name}_eva2_public_nic"
  }
}

resource "outscale_nic" "eva2_sync_nic" {
  subnet_id          = outscale_subnet.hasync_subnet.subnet_id
  security_group_ids = [outscale_security_group.ha_sg.security_group_id]

  private_ips {
    is_primary = true
    private_ip = var.eva2_sync_ip
  }

  tags {
    key   = "name"
    value = "${var.project_name}_eva2_sync_nic"
  }
}

resource "outscale_nic" "eva2_private_nic" {
  subnet_id          = outscale_subnet.private_subnet.subnet_id
  security_group_ids = [outscale_security_group.ha_sg.security_group_id]

  private_ips {
    is_primary = true
    private_ip = var.eva2_private_ip
  }

  tags {
    key   = "name"
    value = "${var.project_name}_eva2_private_nic"
  }
}


resource "outscale_vm" "eva2" {
  image_id               = var.eva_omi
  vm_type                = var.eva_vm_type
  keypair_name           = var.keypair
  is_source_dest_checked = false

  nics {
    device_number = "0"
    nic_id        = outscale_nic.eva2_public_nic.nic_id
  }

  nics {
    nic_id        = outscale_nic.eva2_sync_nic.nic_id
    device_number = "1"
  }

  nics {
    nic_id        = outscale_nic.eva2_private_nic.nic_id
    device_number = "2"
  }

  tags {
    key   = "name"
    value = "${var.project_name}_EVA2"
  }

  tags {
    key   = "osc.fcu.repulse_cluster"
    value = "snsha"
  }

  user_data = base64encode(
    templatefile("conf_eva.sh",
      {
        "NAME"     = "HA_EVA2"
        "WANIP"    = var.eva2_public_ip
        "SYNCIP"   = var.eva2_sync_ip
        "LANIP"    = var.eva2_private_ip
        "MASK"     = var.eva_mask
        "GWIP"     = var.gateway_ip
        "SERVERIP" = var.server_ip
        "PASSWORD" = var.eva_password
      }
    )
  )
}
