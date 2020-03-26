resource "aws_eks_node_group" "prombench-nodegroup" {
  cluster_name    = "${aws_eks_cluster.prombench.name}"
  node_group_name = "${var.node_group_name}"
  node_role_arn   = "${aws_iam_role.prombench-nodegroup.arn}"
  subnet_ids      = ["${aws_subnet.subnet-1.id}", "${aws_subnet.subnet-2.id}"]
	instance_types		=	"${var.instance_types}"
	ami_type				=	"${var.ami_type}"
	disk_size				= "${var.disk_size}"

  scaling_config {
    desired_size = 2
    max_size     = 2
    min_size     = 1
  }

  depends_on = [
    "aws_iam_role_policy_attachment.prombench-AmazonEKSWorkerNodePolicy",
    "aws_iam_role_policy_attachment.prombench-AmazonEKS_CNI_Policy",
    "aws_iam_role_policy_attachment.prombench-AmazonEC2ContainerRegistryReadOnly",
  ]
}