data "linode_regions" "filtered-regions" {
  filter {
    name   = "status"
    values = ["ok"]
  }

  filter {
    name   = "capabilities"
    values = ["NodeBalancers"]
  }
}


