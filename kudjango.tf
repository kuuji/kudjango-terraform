provider "aws" {
    access_key = "${var.access_key}"
    secret_key = "${var.secret_key}"
    region = "${var.region}"
}

# Create a VPC to launch our instances into
resource "aws_vpc" "default" {
  cidr_block = "10.0.0.0/16"
}

# Create an internet gateway to give our subnet access to the outside world
resource "aws_internet_gateway" "default" {
  vpc_id = "${aws_vpc.default.id}"
}

# Grant the VPC internet access on its main route table
resource "aws_route" "internet_access" {
  route_table_id         = "${aws_vpc.default.main_route_table_id}"
  destination_cidr_block = "0.0.0.0/0"
  gateway_id             = "${aws_internet_gateway.default.id}"
}

# Create a subnet to launch our instances into
resource "aws_subnet" "default" {
  vpc_id                  = "${aws_vpc.default.id}"
  cidr_block              = "10.0.1.0/24"
  map_public_ip_on_launch = true
}



# Security group
resource "aws_security_group" "default" {
  name        = "kudjango_sg"
  description = "Used in the kudjango infrastructure"
  vpc_id      = "${aws_vpc.default.id}"

  # SSH access from anywhere
  ingress {
    from_port   = 22
    to_port     = 22
    protocol    = "tcp"
    cidr_blocks = ["0.0.0.0/0"]
  }

  # HTTP access from anywhere
  ingress {
    from_port   = 80
    to_port     = 80
    protocol    = "tcp"
    cidr_blocks = ["0.0.0.0/0"]
  }

  # ALL access from the VPC
ingress {
  from_port   = 0
  to_port     = 0
  protocol    = "-1"
  cidr_blocks = ["10.0.0.0/16"]
}

  # outbound internet access
  egress {
    from_port   = 0
    to_port     = 0
    protocol    = "-1"
    cidr_blocks = ["0.0.0.0/0"]
  }
}


resource "aws_instance" "kudjango-front" {
    ami = "ami-a4dd7ed7"
    instance_type = "t1.micro"
    # The name of our SSH keypair we created above.
    key_name = "mac-alex"

    # Our Security group to allow HTTP and SSH access
    vpc_security_group_ids = ["${aws_security_group.default.id}"]

    # We're going to launch into the same subnet as our ELB. In a production
    # environment it's more common to have a separate private subnet for
    # backend instances.
    subnet_id = "${aws_subnet.default.id}"

}

resource "aws_instance" "kudjango-app00" {
    ami = "ami-c71ab9b4"
    instance_type = "t1.micro"
    # The name of our SSH keypair we created above.
    key_name = "mac-alex"

    # Our Security group to allow HTTP and SSH access
    vpc_security_group_ids = ["${aws_security_group.default.id}"]

    # We're going to launch into the same subnet as our ELB. In a production
    # environment it's more common to have a separate private subnet for
    # backend instances.
    subnet_id = "${aws_subnet.default.id}"

}

resource "aws_instance" "kudjango-app01" {
    ami = "ami-c71ab9b4"
    instance_type = "t1.micro"
    # The name of our SSH keypair we created above.
    key_name = "mac-alex"

    # Our Security group to allow HTTP and SSH access
    vpc_security_group_ids = ["${aws_security_group.default.id}"]

    # We're going to launch into the same subnet as our ELB. In a production
    # environment it's more common to have a separate private subnet for
    # backend instances.
    subnet_id = "${aws_subnet.default.id}"

}

resource "aws_instance" "kudjango-db" {
    ami = "ami-a4dd7ed7"
    instance_type = "t1.micro"
    # The name of our SSH keypair we created above.
    key_name = "mac-alex"

    # Our Security group to allow HTTP and SSH access
    vpc_security_group_ids = ["${aws_security_group.default.id}"]

    # We're going to launch into the same subnet as our ELB. In a production
    # environment it's more common to have a separate private subnet for
    # backend instances.
    subnet_id = "${aws_subnet.default.id}"

}
