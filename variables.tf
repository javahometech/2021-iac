variable "vpc_cidr" {
  default     = "10.0.0.0/16"
  description = "choose cidr for your vpc"
  type        = string
}

variable "web_ami" {
  default     = "ami-0533f2ba8a1995cf9"
  description = "choose ami for web app"
  type        = string
}

variable "web_s3_bucket" {
  default = "javahome123-dev"
}