# provider "tencentcloud" {
#   secret_id  = "xx"
#   secret_key = "xx"
#   region     = "xx"
# }

provider "tencentcloud" {
}

terraform {
  required_version = ">= 0.13"

  required_providers {
   tencentcloud = {
        source = "tencentcloudstack/tencentcloud"
        version = "~> 1.60.18"
    }
  }
}
