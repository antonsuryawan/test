resource "aws_instance" "antontest" {
  # debian stretch
  ami = "ami-00a5fc80ec944398f"

  instance_type   = "t2.micro"
  security_groups = ["${aws_security_group.antontestechoserver.name}"]
  key_name        = "${var.tf_aws_key_name}"

  provisioner "remote-exec" {
    connection {
      type        = "ssh"
      host        = "${self.public_ip}"
      user        = "${var.tf_aws_ssh_user}"
      private_key = "${file("${var.tf_aws_private_key}")}"
    }

    inline = [
      "sudo apt-get update",
      "sudo apt-get install -y apt-transport-https ca-certificates curl gnupg2 software-properties-common",
      "curl -fsSL https://download.docker.com/linux/debian/gpg | sudo apt-key add -",
      "sudo add-apt-repository \"deb [arch=amd64] http://download.docker.com/linux/debian $(lsb_release -cs) stable\"",
      "sudo apt-get update",
      "sudo apt-get install -y docker-ce docker-compose",
      "sudo systemctl daemon-reload",
      "sudo systemctl enable docker",
      "sudo systemctl restart docker",
      "sudo usermod -aG docker ${var.tf_aws_ssh_user}",
      "sudo usermod -aG docker ${var.tf_aws_ssh_user}",
      "docker pull ${var.echoserver_docker_image}",
      "docker run -d -p 1323:1323 ${var.echoserver_docker_image}"
    ]
  }

  tags = {
    Name = "antontest-echoserver"
  }
}

