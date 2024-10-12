# Domain and DNS
module "dns" {
  source = "../infra/dns"
  
  environment = var.environment
  domains     = var.domains
}
