# Environment to deploy to
variable "environment" {
  description = "The environment to deploy to."
  type        = string
}

# Domain names through which environment is accessed
variable "domains" {
  description = "The domain names through which the environment is accessed."
  type        = list(string)
}
