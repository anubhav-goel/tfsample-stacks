required_providers {
  random = {
    source  = "hashicorp/random"
    version = "~> 3.5.1"
  }
  null = {
    source  = "hashicorp/null"
    version = "~> 3.2.2"
  }
}

provider "random" "this" {}
provider "null" "this" {}

variable "prefix" {
  type = string
}

variable "instances" {
  type = number
}

component "pet" {
  source = "./pet"
  inputs = {
    prefix = var.prefix
  }
  providers = {
    random = provider.random.this
  }
}

component "nulls" {
  source = "./nulls"
  inputs = {
    pet       = component.pet.name
    instances = var.instances
  }
  providers = {
    null = provider.null.this
  }
}

output "name" {
  type = string
  value = component.pet.name
}