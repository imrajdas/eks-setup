output "endpoint" {
  value = "${aws_eks_cluster.prombench.endpoint}"
}

output "kubeconfig-certificate-authority-data" {
  value = "${aws_eks_cluster.prombench.certificate_authority.0.data}"
}