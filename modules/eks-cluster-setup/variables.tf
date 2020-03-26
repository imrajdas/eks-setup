variable "node_group_name" {
  description = "Node group name"
  default = "gitlab-nodegroup"
}

variable "eks_cluster_name" {
  default = "gitlab-eks-cluster"
}

variable "ami_type" {
  default = "AL2_x86_64"
}

variable "disk_size" {
  default = "20"
}

variable "instance_types" {
  default = ["t3.medium"]
}

variable "aws_az1" {
  description = "AWS EC2 availability zone 2"
  default     = "us-east-1a"
}

variable "aws_az2" {
  description = "AWS EC2 availability zone 2"
  default     = "us-east-1b"
}