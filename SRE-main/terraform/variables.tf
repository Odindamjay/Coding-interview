variable "instance_type" {
  default = "t2.micro"
}
variable "sns_topic_name" {
  default = "ec2-restart-notification"
}
variable "region" {
  default = ""
}
