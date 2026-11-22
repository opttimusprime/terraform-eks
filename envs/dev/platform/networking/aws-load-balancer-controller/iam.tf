
# IAM permissions for AWS Load Balancer Controller
resource "aws_iam_policy" "controller" {
  name = local.controller_policy_name

  description = "IAM permissions for AWS Load Balancer Controller"

  policy = file("${path.module}/iam_policy.json")
}

# IAM Role using IRSA
resource "aws_iam_role" "controller" {
  name = local.controller_role_name

  assume_role_policy = data.aws_iam_policy_document.controller_assume_role.json
}

# Attach IAM policy to role
resource "aws_iam_role_policy_attachment" "controller" {
  role       = aws_iam_role.controller.name
  policy_arn = aws_iam_policy.controller.arn
}
