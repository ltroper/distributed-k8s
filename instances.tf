resource "linode_instance" "controlPlaneDistributed" {
  label      = "controlPlaneDistributed"
  tags       = ["k8s"]
  region     = var.regions[4]
  type       = var.master_node
  private_ip = true

  image = "linode/ubuntu20.04"

  root_pass = "linodePasswordDefault"

  # metadata {
  #   user_data = base64encode("echo 'hello world' > helloWorld.txt")
  # }

  connection {
    type     = "ssh"
    user     = "root"
    password = "linodePasswordDefault"
    host     = self.ip_address
  }

  provisioner "file" {
    source      = "./scripts"
    destination = "/"
  }

  provisioner "remote-exec" {
    inline = ["sudo chmod 777 -R /scripts",
      "sudo hostnamectl set-hostname controlplane",
    "/scripts/controlPlane.sh"]
  }

}

resource "null_resource" "copyJoinCommand" {
  depends_on = [linode_instance.controlPlaneDistributed]

  provisioner "local-exec" {
    command = "scp -o StrictHostKeyChecking=no root@${linode_instance.controlPlaneDistributed.ip_address}:/root/join-command.sh ./scripts/"
  }


}

resource "linode_instance" "workerNodes" {
  depends_on = [null_resource.copyJoinCommand]

  count      = var.worker_count
  label      = "workerNodeDistributed-${count.index}"
  tags       = ["k8s", "worker-${count.index}"]
  region     = var.regions[count.index]
  type       = var.worker_nodes
  private_ip = true

  image = "linode/ubuntu20.04"

  root_pass = "linodePasswordDefault"

  # metadata {
  #   user_data = base64encode("echo 'hello world' > helloWorld.txt")
  # }

  connection {
    type     = "ssh"
    user     = "root"
    password = "linodePasswordDefault"
    host     = self.ip_address
  }

  provisioner "file" {
    source      = "./scripts"
    destination = "/"
  }


  provisioner "remote-exec" {
    inline = ["sudo chmod 777 -R /scripts",
    "sudo hostnamectl set-hostname worker${count.index}",
    "/scripts/worker.sh",
    "/scripts/join-command.sh"]
  }
}
