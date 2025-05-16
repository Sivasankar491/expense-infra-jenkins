variable "project" {
    default = "expense" 
}

variable "environment" {
    default = "dev" 
}

variable "mysql_sg_name" {
    default = "mysql"
}

variable "bastion_sg_name" {
    default = "bastion"
}

variable "ingress_alb_sg_name" {
    default = "ingress_alb"
}

variable "node_sg_name" {
    default = "node"
}

variable "control_plane_sg_name" {
    default = "control_plane"
}


variable "common_tags" {
    type = map
    default = {
        Jenkins = "True"
    }
}

variable "mysql_sg_tags" {
    type = map
    default = {
        component = "mysql"
    }
}

variable "bastion_sg_tags" {
    type = map
    default = {
        component = "bastion"
    }
}

variable "ingress_alb_sg_tags" {
    type = map
    default = {
        component = "ingress_alb"
    }
}

variable "node_sg_tags" {
    type = map
    default = {
        component = "node"
    }
}

variable "control_plane_sg_tags" {
    type = map
    default = {
        component = "control_plane"
    }
}