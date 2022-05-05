
/*
 * VPC & subnets
 */

resource "outscale_net" "ha_vpc" {
  ip_range = var.vpc_network
  tags {
    key   = "name"
    value = "${var.project_name}_vpc"
  }
}

resource "outscale_subnet" "public_subnet" {
  net_id         = outscale_net.ha_vpc.net_id
  ip_range       = var.public_subnet
  subregion_name = "${var.region}${var.zone}"
  tags {
    key   = "name"
    value = "${var.project_name}_public_subnet"
  }
}

resource "outscale_subnet" "hasync_subnet" {
  net_id         = outscale_net.ha_vpc.net_id
  ip_range       = var.hasync_subnet
  subregion_name = "${var.region}${var.zone}"
  tags {
    key   = "name"
    value = "${var.project_name}_hasync_subnet"
  }
}

resource "outscale_subnet" "private_subnet" {
  net_id         = outscale_net.ha_vpc.net_id
  ip_range       = var.private_subnet
  subregion_name = "${var.region}${var.zone}"
  tags {
    key   = "name"
    value = "${var.project_name}_private_subnet"
  }
}

/*
 * Internet gateway
 */

resource "outscale_internet_service" "igw" {
  tags {
    key   = "name"
    value = "${var.project_name}_igw"
  }
}

resource "outscale_internet_service_link" "igw_link" {
  internet_service_id = outscale_internet_service.igw.internet_service_id
  net_id              = outscale_net.ha_vpc.net_id
}
