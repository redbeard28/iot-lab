#######################################################
#
#	Deploy configuration
#
#		by J.CUADRADO 06/09/2017
#
########################################################



resource "openstack_compute_keypair_v2" "redbeard28_key_pub" {
  name = "redbeard28_key_pub"
  public_key = "${file("public_keys/redbeard28")}"
}


### Création de la ressource réseau ###
resource "openstack_networking_network_v2" "terraform" {
  name           = "terraform"
  admin_state_up = "true"
}

resource "openstack_networking_subnet_v2" "terraform" {
  name            = "terraform"
  network_id      = "${openstack_networking_network_v2.terraform.id}"
  cidr            = "192.168.10.0/24"
  ip_version      = 4
  dns_nameservers = ["8.8.8.8", "8.8.4.4"]
}

resource "openstack_networking_router_v2" "terraform" {
  name             = "terraform"
  admin_state_up   = "true"
  external_gateway = "${var.external_gateway}"
}

resource "openstack_networking_router_interface_v2" "terraform" {
  router_id = "${openstack_networking_router_v2.terraform.id}"
  subnet_id = "${openstack_networking_subnet_v2.terraform.id}"
}

resource "openstack_compute_floatingip_v2" "terraform" {
  pool       = "${var.pool}"
  depends_on = ["openstack_networking_router_interface_v2.terraform"]
}


resource "openstack_compute_secgroup_v2" "terraform" {
  name        = "terraform"
  description = "Security group for the Terraform example instances"

  rule {
    from_port   = 22
    to_port     = 22
    ip_protocol = "tcp"
    cidr        = "0.0.0.0/0"
  }

  rule {
    from_port   = 80
    to_port     = 80
    ip_protocol = "tcp"
    cidr        = "0.0.0.0/0"
  }

  rule {
    from_port   = 443
    to_port     = 443
    ip_protocol = "tcp"
    cidr        = "0.0.0.0/0"
  }
  
  rule {
    from_port   = -1
    to_port     = -1
    ip_protocol = "icmp"
    cidr        = "0.0.0.0/0"
  }
}

resource "openstack_compute_secgroup_v2" "thingsboard" {
  name        = "thingsboard"
  description = "Security group for thingsboard"

  rule {
    from_port   = 1883
    to_port     = 1883
    ip_protocol = "tcp"
    cidr        = "0.0.0.0/0"
  }
  
  rule {
    from_port   = -1
    to_port     = -1
    ip_protocol = "icmp"
    cidr        = "0.0.0.0/0"
  }
}

resource "openstack_compute_instance_v2" "front" {
  name = "front"
  image_id = "${var.openstack_ubuntu_image_id}"
  availability_zone = "nova"
  flavor_name = "$(var.front-image-flavor)"
  key_pair = "${openstack_compute_keypair_v2.redbeard28_key_pub.name}"
  security_groups = ["terraform"]
  network {
    uuid = "${openstack_networking_network_v2.terraform.id}"
  }
  floating_ip = "${openstack_compute_floatingip_v2.terraform.address}"
}

resource "openstack_compute_instance_v2" "thingsboard" {
  name = "thingsboard"
  image_id = "${var.openstack_ubuntu_image_id}"
  availability_zone = "nova"
  flavor_name = "$(var.thingsboard-image-flavor)"
  key_pair = "${openstack_compute_keypair_v2.redbeard28_key_pub.name}"
  security_groups = ["thingsboard"]
  network {
    uuid = "${openstack_networking_network_v2.terraform.id}"
  }
  floating_ip = "${openstack_compute_floatingip_v2.terraform.address}"
}

resource "openstack_compute_instance_v2" "nodered" {
  name = "nodered"
  image_id = "${var.openstack_ubuntu_image_id}"
  availability_zone = "nova"
  flavor_name = "$(var.nodered-image-flavor)"
  key_pair = "${openstack_compute_keypair_v2.redbeard28_key_pub.name}"
  security_groups = ["terraform"]
  network {
    uuid = "${openstack_networking_network_v2.terraform.id}"
  }
}

resource "openstack_compute_instance_v2" "guacamole" {
  name = "guacamole"
  image_id = "${var.openstack_ubuntu_image_id}"
  availability_zone = "nova"
  flavor_name = "$(var.guacamole-image-flavor)"
  key_pair = "${openstack_compute_keypair_v2.redbeard28_key_pub.name}"
  security_groups = ["terraform"]
  network {
    uuid = "${openstack_networking_network_v2.terraform.id}"
  }
}