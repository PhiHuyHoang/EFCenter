variable "MESSAGE" {
  type        = string
  description = "Message to send to the application"
  default     = "Hello EF center"
}

variable "region" {
  type        = string
  description = "Region to run aws"
  default     = "eu-west-1"
}

variable "bucket" {
  type        = string
  description = "Bucket name"
  default     = "efcentersystem09132023"
}
