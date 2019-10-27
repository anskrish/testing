resource "aws_instance" "instance1" {
  ami             = "ami-0565af6e282977273"
  instance_type   = "t2.micro"
  key_name = "new-awskrish"
  security_groups = ["default"]

  tags = {
    Name = "instance1"
  }
}
#resource "aws_instance" "instance2" {
#  ami             = "ami-0565af6e282977273"
#  instance_type   = "t2.micro"
#  key_name = "kri007"
#  security_groups = ["default"]
#
#  tags = {
#    Name = "instance2"
#  }
#}
resource "aws_elb" "testing1" {
  name               = "testing-elb"
  availability_zones = ["us-east-1a", "us-east-1b", "us-east-1c", "us-east-1d"]
listener {
    instance_port     = 80
    instance_protocol = "http"
    lb_port           = 80
    lb_protocol       = "http"
  }
health_check {
    healthy_threshold   = 2
    unhealthy_threshold = 2
    timeout             = 3
    target              = "HTTP:80/"
    interval            = 30
  }
#instances                   = ["${aws_instance.instance1.id}", "${aws_instance.instance2.id}"]
instances                   = ["${aws_instance.instance1.id}"]
  cross_zone_load_balancing   = true
  idle_timeout                = 400
  connection_draining         = true
  connection_draining_timeout = 400

  tags = {
    Name = "testing-elb"
  }
}

