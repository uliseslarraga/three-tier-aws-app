resource "aws_iam_instance_profile" "ec2_profile" {
  name = "ec2_profile_${var.environment}"
  role = aws_iam_role.role.name
}

data "aws_iam_policy_document" "ssm_policy" {
  statement {
    effect = "Allow"
    actions = [
      "ssm:UpdateInstanceInformation",
      "ssmmessages:CreateControlChannel",
      "ssmmessages:CreateDataChannel",
      "ssmmessages:OpenControlChannel",
      "ssmmessages:OpenDataChannel"
    ]
    resources = ["*"]
  }
} 

resource "aws_iam_policy" "s3_read_only_policy" {
  name        = "s3_readonly_policy_${var.environment}"
  description = "Allows readonly access to s3 bucket objects"

  # Terraform's "jsonencode" function converts a
  # Terraform expression result to valid JSON syntax.
  policy = jsonencode({
    Version = "2012-10-17"
    Statement = [
      {
        Action = [
          "s3:Get*",
          "s3:List*",
          "s3:Describe*",
          "s3-object-lambda:Get*",
          "s3-object-lambda:List*",
        ]
        Effect   = "Allow"
        Resource = "*"
      },
    ]
  })
}

data "aws_iam_policy_document" "assume_role_policy" {
  statement {
    effect = "Allow"

    principals {
      type        = "Service"
      identifiers = ["ec2.amazonaws.com"]
    }

    actions = ["sts:AssumeRole"]
  }
}

resource "aws_iam_role" "role" {
  name               = "ec2_role_${var.environment}"
  assume_role_policy = data.aws_iam_policy_document.assume_role_policy.json
  inline_policy {
    name   = "policy-${var.environment}-8675309"
    policy = data.aws_iam_policy_document.ssm_policy.json
  }
}

resource "aws_iam_role_policy_attachment" "s3-read-only-attach" {
  role       = aws_iam_role.role.name
  policy_arn = aws_iam_policy.s3_read_only_policy.arn
}

resource "aws_ssm_document" "ssm_document" {
  name          = "ssm_document_runShellAsEc2User_${var.environment}"
  document_type = "Session"

  content = <<DOC
  {
      "schemaVersion": "1.0",
      "description": "Document to hold regional settings for Session Manager",
      "sessionType": "Standard_Stream",
      "inputs": {
          "s3BucketName": "",
          "s3KeyPrefix": "",
          "s3EncryptionEnabled": true,
          "cloudWatchLogGroupName": "",
          "cloudWatchEncryptionEnabled": true,
          "cloudWatchStreamingEnabled": true,
          "kmsKeyId": "",
          "runAsEnabled": true,
          "runAsDefaultUser": "ec2-user",
          "idleSessionTimeout": "20",
          "maxSessionDuration": "60",
          "shellProfile": {
              "linux": "whoami"
          }
      }
  }
DOC
}