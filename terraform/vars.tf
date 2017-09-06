#######################################################
#
#	Vars configuration
#
#		by J.CUADRADO 06/09/2017
#
#######################################################


#######################################################
#### OS - key_pairs ####
variable "openstack_ubuntu_image_id" {
    description = "ubuntu-17.04-x64"
    default = "942d4f8a-184f-4ffb-a9aa-aa29943f8ab2"
}

variable "front-image-flavor" {
  default = "Small"
}

variable "thingsboard-image-flavor" {
  default = "XSmall"
}

variable "nodered-image-flavor-image-flavor" {
  default = "Medium"
}

variable "openstack_keypair" {
    description = "The keypair to be used."
    default  = "demo_key"
}

#######################################################
#### Reverse Proxy nodes ####
variable "node-count" {
  default ="4"
}


#######################################################
#### Networking stuff ####
#variable "openstack_tenant_network" {
#    description = "The network to be used."
#    default  = "b8a28df2-7f9d-4b2a-8f34-0e1d63c8a78b"
#}

#### ID of Floating-IPs declaration ####
variable "external_gateway" {
    default = "45306006-f2c9-48bc-a029-028cc3b0a86c"
}

#### Pool of floating IPs ####
variable "pool" {
  default = "internet_floating_net"
}




