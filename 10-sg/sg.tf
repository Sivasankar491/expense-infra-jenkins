module "mysql_sg" {
    source = "git::https://github.com/Sivasankar491/Terraform-sg-module.git?ref=main"
    # source = "../../Terraform-sg-module"
    project = var.project
    environment = var.environment
    sg_name = var.mysql_sg_name
    vpc_id = local.vpc_id
    common_tags = var.common_tags
    sg_tags = var.mysql_sg_tags
}

module "bastion_sg" {
    source = "git::https://github.com/Sivasankar491/Terraform-sg-module.git?ref=main"
    project = var.project
    environment = var.environment
    sg_name = var.bastion_sg_name
    vpc_id = local.vpc_id
    common_tags = var.common_tags
    sg_tags = var.bastion_sg_tags
}

module "node_sg" {
  source = "git::https://github.com/Sivasankar491/Terraform-sg-module.git?ref=main"
  project = var.project
  environment = var.environment
  sg_name = var.node_sg_name
  vpc_id = local.vpc_id
  common_tags = var.common_tags
  sg_tags = var.ingress_alb_sg_tags
}

module "control_plane_sg" {
  source = "git::https://github.com/Sivasankar491/Terraform-sg-module.git?ref=main"
  project = var.project
  environment = var.environment
  sg_name = var.control_plane_sg_name
  vpc_id = local.vpc_id
  common_tags = var.common_tags
  sg_tags = var.control_plane_sg_tags
}

module "ingress_alb_sg" {
    source = "git::https://github.com/Sivasankar491/Terraform-sg-module.git?ref=main"
    project = var.project
    environment = var.environment
    sg_name = var.ingress_alb_sg_name
    vpc_id = local.vpc_id
    common_tags = var.common_tags
    sg_tags = var.ingress_alb_sg_tags
}

resource "aws_security_group_rule" "ingress_alb_on_https" {
  type              = "ingress"
  from_port         = 443
  to_port           = 443
  protocol          = "tcp"
  cidr_blocks = ["0.0.0.0/0"]
  security_group_id = module.ingress_alb_sg.id
}

resource "aws_security_group_rule" "node_from_ingress_alb" {
  type              = "ingress"
  from_port         = 30000
  to_port           = 32767
  protocol          = "tcp"
  source_security_group_id = module.ingress_alb_sg.id
  security_group_id = module.node_sg.id
}

resource "aws_security_group_rule" "node_from_control_plane" {
  type              = "ingress"
  from_port         = 0
  to_port           = 0
  protocol          = "-1"
  source_security_group_id = module.control_plane_sg.id
  security_group_id = module.node_sg.id
}

resource "aws_security_group_rule" "control_plane_from_node" {
  type              = "ingress"
  from_port         = 0
  to_port           = 0
  protocol          = "-1"
  source_security_group_id = module.node_sg.id
  security_group_id = module.control_plane_sg.id
}

resource "aws_security_group_rule" "control_plane_from_bastion" {
  type              = "ingress"
  from_port         = 443
  to_port           = 443
  protocol          = "tcp"
  source_security_group_id = module.bastion_sg.id
  security_group_id = module.control_plane_sg.id
}

resource "aws_security_group_rule" "node_from_vpc" {
  type              = "ingress"
  from_port         = 0
  to_port           = 0
  protocol          = "-1"
  cidr_blocks = ["10.0.0.0/16"]
  security_group_id = module.node_sg.id
}

resource "aws_security_group_rule" "mysql_from_bastion" {
  type              = "ingress"
  from_port         = 3306
  to_port           = 3306
  protocol          = "tcp"
  source_security_group_id = module.bastion_sg.id
  security_group_id = module.mysql_sg.id
}

resource "aws_security_group_rule" "node_from_bastion" {
  type              = "ingress"
  from_port         = 22
  to_port           = 22
  protocol          = "tcp"
  source_security_group_id = module.bastion_sg.id
  security_group_id = module.node_sg.id
}

resource "aws_security_group_rule" "bastion_from_public" {
  type              = "ingress"
  from_port         = 22
  to_port           = 22
  protocol          = "tcp"
  cidr_blocks = ["0.0.0.0/0"]
  security_group_id = module.bastion_sg.id
}

resource "aws_security_group_rule" "ingress_alb_from_bastion" {
  type              = "ingress"
  from_port         = 443
  to_port           = 443
  protocol          = "tcp"
  source_security_group_id = module.bastion_sg.id
  security_group_id = module.ingress_alb_sg.id
}








resource "aws_security_group_rule" "mysql_from_node" {
  type              = "ingress"
  from_port         = 3306
  to_port           = 3306
  protocol          = "tcp"
  source_security_group_id = module.node_sg.id
  security_group_id = module.mysql_sg.id
}