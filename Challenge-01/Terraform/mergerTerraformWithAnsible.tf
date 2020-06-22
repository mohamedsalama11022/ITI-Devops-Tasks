provider "aws" {
  region = "us-east-2"
  profile = "default"
}


resource "aws_instance" "ec2" {
  ami = "ami-0f7919c33c90f5b58"
  instance_type = "t2.micro"
  key_name = "Admin II-lab2"
  
  tags  = {
      Name = "challenge01"
  }
  provisioner "local-exec" {
      command = "echo -e '[web]\n${aws_instance.ec2.public_ip}'> inventory"
  }

  provisioner "local-exec" {
    command = "sleep 10; ssh-add AdminII-lab2.pem; ssh-copy-id ec2-user@${aws_instance.ec2.public_ip} "
  }

  provisioner "local-exec" {
      command = "sleep 10;ANSIBLE_HOST_KEY_CHECKING=False ansible-playbook config.yml -i inventory"
  }

}
