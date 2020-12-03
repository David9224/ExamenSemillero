provider "aws" {
  region  = var.region
  profile = "default"
}

resource "aws_instance" "instance_david_a" {
  ami           = var.ami_small
  instance_type = var.instance_small
  tags = {
    Name = "instance_david_a"
  }
}

resource "aws_db_instance" "db_david_a" {
  instance_class       = "db.t2.micro"
  allocated_storage    = 20
  storage_type         = "gp2"
  engine               = "mysql"
  engine_version       = "5.7"
  name                 = "mydb"
  username             = "user"
  password             = "passwordtemporal"
  parameter_group_name = "default.mysql5.7"
  skip_final_snapshot  = true
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
  name   = "userx_policy"
  user   = aws_iam_user.user_david_a.name
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