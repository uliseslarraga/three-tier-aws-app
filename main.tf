module "newtwork"{
    source      = "./modules/network"
    vpc_cidr    = var.vpc_cidr
    environment = var.environment
    tags        = var.tags
}