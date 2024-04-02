module "network"{
    source      = "./modules/network"
    vpc_cidr    = var.vpc_cidr
    environment = var.environment
    tags        = var.tags
}

module "compute"{
    source           = "./modules/compute"
    instance_type    = var.instance_type
    tags             = var.tags
    vpc_id           = module.network.vpc_id
    private_subnets  = module.network.priv_subnet_ids
    public_subnets   = module.network.pub_subnet_ids
    desired_capacity = var.desired_capacity 
    max_size         = var.max_size
    min_size         = var.min_size
    depends_on = [
        module.network
    ]
}