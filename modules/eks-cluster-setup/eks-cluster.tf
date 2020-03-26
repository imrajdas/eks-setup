resource "aws_eks_cluster" "prombench" {
  name     = "${var.eks_cluster_name}"
  role_arn = "${aws_iam_role.prombench-eks-cluster.arn}"

  vpc_config {
    security_group_ids = ["${aws_security_group.prombench-sg.id}"]
    subnet_ids = ["${aws_subnet.subnet-1.id}", "${aws_subnet.subnet-2.id}"]
  }

  depends_on = [
    "aws_iam_role_policy_attachment.prombench-AmazonEKSClusterPolicy",
    "aws_iam_role_policy_attachment.prombench-AmazonEKSServicePolicy",
  ]
}