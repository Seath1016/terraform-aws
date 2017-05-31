provider "aws" {
  region     = "us-west-2"
}

resource "aws_instance" "example" {
  ami           = "ami-45224425"
  instance_type = "t2.micro"
  key_name	= "id_rsa"
  
  provisioner "file" {
    source      = "script.sh"
    destination = "/home/ubuntu/script.sh"
    connection {
        type = "ssh"
	user = "ubuntu"
        private_key = "${file("/home/vagrant/.ssh/id_rsa")}"
        agent =  false
    }
  }

  provisioner "remote-exec" {
    inline = [
      "chmod 775 /home/ubuntu/script.sh",  
      "/home/ubuntu/script.sh"
    ]
    connection {
        type = "ssh"
        user = "ubuntu"
        private_key = "${file("/home/vagrant/.ssh/id_rsa")}"
        agent =  false
    }
  }
}

resource "aws_eip" "ip" {
  instance = "${aws_instance.example.id}"
}
