data "aws_eks_cluster" "this" {
    name = aws_eks_cluster.this.name
    depends_on = [aws_eks_cluster.this]
}

data "aws_eks_cluster_auth" "this" {
    name = aws_eks_cluster.this.name
    depends_on = [aws_eks_cluster.this]
}

provider "helm" {
  kubernetes {
    host                   = data.aws_eks_cluster.eks.endpoint
    cluster_ca_certificate = base64decode(data.aws_eks_cluster.eks.certificate_authority[0].data)
    exec {
      api_version = "client.authentication.k8s.io/v1beta1"
      args        = ["eks", "get-token", "--cluster-name", data.aws_eks_cluster.eks.name]
      command     = "aws"
    }
    depends_on = [aws_eks_cluster.this]
  }
}