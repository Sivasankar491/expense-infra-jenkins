variable "environment" {
  type = string
  default = "dev"
}

variable "project" {
    type = string
    default = "expense"
}

variable "common_tags" {
    default = {
        Project = "expense"
        Terraform = "true"
        Environment = "dev"
    }
}

variable "cidr_block" {
    default = "10.0.0.0/16"
}

variable "public_subnets" {
    default = ["10.0.1.0/24", "10.0.2.0/24"]  
}

variable "private_subnets" {
    default = ["10.0.11.0/24", "10.0.12.0/24"]  
}

variable "database_subnets" {
    default = ["10.0.21.0/24", "10.0.22.0/24"]  
}

variable "is_peering_required" {
  default = true
}