terraform {
  required_providers {
    aws = {
      source  = "hashicorp/aws"
      version = ">= 4.16"
    }
  }

  required_version = ">= 1.9.5"
}

provider "aws" {
  region = "eu-central-1"
}

locals {
  usernames = toset(compact(split("\n", file("usernames.txt"))))
}

resource "aws_iam_group" "adminstrators" {
  name = "Administrators"
}

resource "aws_iam_group_policy_attachment" "administrator_access" {
  group      = aws_iam_group.adminstrators.name
  policy_arn = "arn:aws:iam::aws:policy/AdministratorAccess"
}

resource "aws_iam_user" "user" {
  for_each = toset(local.usernames)
  name  = each.key
}

resource "aws_iam_user_group_membership" "user_administrator" {
  for_each = aws_iam_user.user
  user   = each.key
  groups = [aws_iam_group.adminstrators.name]
}