module "vpc" {
    source = "git::https://github.com/Sivasankar491/terraform-vpc-module1.git?ref=main"
    environment = var.environment
    project = var.project
    cidr_block = var.cidr_block
    common_tags = var.common_tags
    public_subnets = var.public_subnets
    private_subnets = var.private_subnets
    database_subnets = var.database_subnets
    is_peering_required = var.is_peering_required
}