variable "env" {
  description = "environment"
  type        = string
}

variable "region" {
  description = "aws region"
  type        = string
}

variable "account_id" {
  description = "aws account id"
  type        = string
}

variable "tags" {
  description = "tags"
  type        = map(string)
}