provider "aws" {
  region     = "us-west-2"
}

resource "aws_instance" "docker-host" {
  ami           = "ami-45224425"
  instance_type = "t2.micro"
  key_name	= "id_rsa"

  provisioner "file" {
    source      = "ansible"
    destination = "/home/ubuntu/ansible"
    connection {
        type = "ssh"
	user = "ubuntu"
        private_key = "${file("~/.ssh/aws_id_rsa")}"
        agent =  false
    }
  }

  provisioner "remote-exec" {
    inline = [
      "chmod 775 /home/ubuntu/ansible/script.sh",
      "/home/ubuntu/ansible/script.sh",
      "/home/ubuntu/.local/bin/ansible-playbook -i ansible/hosts ansible/main.yml"
    ]
    connection {
        type = "ssh"
        user = "ubuntu"
        private_key = "${file("~/.ssh/aws_id_rsa")}"
        agent =  false
    }
  }
}

resource "aws_eip" "ip" {
  instance = "${aws_instance.docker-host.id}"
}
