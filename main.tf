# create vpc
resource "tencentcloud_vpc" "dev" {
  name         = var.vpc_name
  cidr_block   = var.vpc_cidr
  dns_servers  = ["119.29.29.29", "8.8.8.8"]
  is_multicast = false
  tags = var.vpc_tag
}

# create subnet
resource "tencentcloud_subnet" "public" {
  availability_zone = var.availability_zone
  name              = "dev-public"
  vpc_id            = tencentcloud_vpc.dev.id
  cidr_block        = var.public_subnet
  is_multicast      = false
}

resource "tencentcloud_subnet" "private" {
  availability_zone = var.availability_zone
  name              = "dev-private"
  vpc_id            = tencentcloud_vpc.dev.id
  cidr_block        = var.private_subnet
  is_multicast      = false
}

# security group
resource "tencentcloud_security_group" "bastion_sg" {
  name        = "bastion"
}

resource "tencentcloud_security_group_rule" "bastion_inbound" {
  security_group_id = tencentcloud_security_group.bastion_sg.id
  type              = "ingress"
  cidr_ip           = var.bastion_ssh
  ip_protocol       = "TCP"
  port_range        = "22"
  policy            = "ACCEPT"
  description       = "bastion sg"
}

# bastion instance
# Get availability instance types
data "tencentcloud_instance_types" "default" {
  cpu_core_count = 1
  memory_size    = 1
}
# Get availability images
data "tencentcloud_images" "default" {
  image_type = ["PUBLIC_IMAGE"]
  os_name    = "centos"
}

# Create a bastion vm
resource "tencentcloud_instance" "bastion" {
  instance_name              = "bastion"
  availability_zone          = var.availability_zone
  image_id                   = data.tencentcloud_images.default.images.0.image_id
  instance_type              = data.tencentcloud_instance_types.default.instance_types.0.instance_type
  system_disk_type           = "CLOUD_PREMIUM"
  system_disk_size           = 50
  allocate_public_ip         = true
  internet_max_bandwidth_out = 20
  security_groups            = [tencentcloud_security_group.bastion_sg.id]
  count                      = 1
}
