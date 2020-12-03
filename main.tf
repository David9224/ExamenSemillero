provider "aws" {
  region = var.region
  profile = "default"
}

resource "aws_instance" "instance_david_a" {
  ami = var.ami_small
  instance_type = var.instance_small
  tags = {
    Name = "instance_david_a"
  }
  vpc_security_group_ids = [
    aws_security_group.instance.id]

}

resource "aws_security_group" "instance" {
  name = "terraform-instance"
  ingress {
    from_port = 0
    to_port = 0
    protocol = -1
    cidr_blocks = [
      "0.0.0.0/0"]
  }
  egress {
    from_port = 0
    to_port = 0
    protocol = "-1"
    cidr_blocks = [
      "0.0.0.0/0"]
  }
}

resource "aws_db_instance" "db_david_a" {
  instance_class = "db.t2.micro"
  allocated_storage = 20
  storage_type = "gp2"
  engine = "postgres"
  engine_version = "12.4"
  name = "mydb"
  username = "root"
  password = "passwordtemporal"
  parameter_group_name = "default.postgres12"
  skip_final_snapshot = true
}

resource "aws_iam_user" "user_david_a" {
  name = "userx_david_a"
  path = "/system/"
  tags = {
    source = "terraform"
  }
}

resource "aws_iam_access_key" "userx_david_a" {
  user = aws_iam_user.user_david_a.name
}

resource "aws_iam_user_policy" "userx_policy" {
  name = "userx_policy"
  user = aws_iam_user.user_david_a.name
  policy = data.aws_iam_policy_document.policy_test.json

}

data "aws_iam_policy_document" "policy_test" {
  statement {
    actions = [
      "ec2:*",
      "rds:*"
    ]
    resources = [
      aws_instance.instance_david_a.arn,
      aws_db_instance.db_david_a.arn
    ]
  }
}