module "s3-module" {
  source = "./modules/s3-module"
  bucket = var.bucket
}