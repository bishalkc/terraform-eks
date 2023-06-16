# Locals for common
locals {
  project     = "demo-cluster"
  environment = "dev"
  tenant      = "DC"
  framework   = "drupal"

  # db = {
  #   type          = "mariadb"
  #   version       = "10.5.0"
  #   port          = 3306
  #   instance_type = "db.t3.medium"
  # }
}
