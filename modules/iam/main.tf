data "aws_iam_policy_document" "ecs_task_doc" {
  statement {
    effect = "Allow"
    principals {
      type        = "Service"
      identifiers = ["ecs-tasks.amazonaws.com"]
    }
    actions = ["sts:AssumeRole"]
  }
}

data "aws_iam_policy_document" "ecs_exec_doc" {
  version = "2012-10-17"
  statement {
    effect = "Allow"
    actions = [
      "ssmmessages:CreateControlChannel",
      "ssmmessages:CreateDataChannel",
      "ssmmessages:OpenControlChannel",
      "ssmmessages:OpenDataChannel"
    ]
    resources = ["*"]
  }
}

data "aws_iam_policy_document" "ecs_parameter_doc" {
  version = "2012-10-17"
  statement {
    effect = "Allow"
    actions = ["ssm:DescribeParameters"]
    resources = ["*"]
  }
  statement {
    effect = "Allow"
    actions = ["ssm:GetParameters"]
    resources = ["arn:aws:ssm:ap-northeast-1:${var.account_id}:parameter/*"]
  }
}

resource "aws_iam_policy" "ecs_exec_policy" {
  name   = "ecsExecPolicy"
  policy = data.aws_iam_policy_document.ecs_exec_doc.json
}

resource "aws_iam_policy" "ecs_parameter_policy" {
  name   = "ecsParameterPolicy"
  policy = data.aws_iam_policy_document.ecs_parameter_doc.json
}

resource "aws_iam_role_policy_attachment" "task_attachement" {
  role       = aws_iam_role.task_role.name
  policy_arn = aws_iam_policy.ecs_exec_policy.arn
}

resource "aws_iam_role_policy_attachment" "execution_attachement" {
  role       = aws_iam_role.execution_role.name
  policy_arn = "arn:aws:iam::aws:policy/service-role/AmazonECSTaskExecutionRolePolicy"
}

resource "aws_iam_role_policy_attachment" "parameter_attachement" {
  role       = aws_iam_role.execution_role.name
  policy_arn = aws_iam_policy.ecs_parameter_policy.arn
}

resource "aws_iam_role" "task_role" {
  name               = "task-role"
  assume_role_policy = data.aws_iam_policy_document.ecs_task_doc.json
}

resource "aws_iam_role" "execution_role" {
  name               = "execution-role"
  assume_role_policy = data.aws_iam_policy_document.ecs_task_doc.json
}

resource "aws_iam_user" "image_botapeer_com_user" {
  name = "image.botapeer.com"
}

data "aws_iam_policy_document" "image_botapeer_com_s3_doc" {
  version = "2012-10-17"
  statement {
    effect = "Allow"
    actions = [
      "s3:PutObject"
    ]
    resources = ["${var.image_s3.arn}/*"]
  }
}

resource "aws_iam_policy" "image_botapeer_com_s3_policy" {
  name   = "imageBotapeerS3Policy"
  policy = data.aws_iam_policy_document.image_botapeer_com_s3_doc.json
}

resource "aws_iam_user_policy_attachment" "image_botapeer_com_user_policy" {
  user       = aws_iam_user.image_botapeer_com_user.name
  policy_arn = aws_iam_policy.image_botapeer_com_s3_policy.arn
}

data "aws_iam_policy_document" "apprunner_doc" {
  statement {
    effect = "Allow"
    principals {
      type        = "Service"
      identifiers = ["build.apprunner.amazonaws.com"]
    }
    actions = ["sts:AssumeRole"]
  }
}

resource "aws_iam_role" "apprunner_ecr_role" {
  name               = "apprunner-ecr-role"
  assume_role_policy = data.aws_iam_policy_document.apprunner_doc.json
}

resource "aws_iam_role_policy_attachment" "apprunner_ecr_assumerole_policy" {
  role       = aws_iam_role.apprunner_ecr_role.name
  policy_arn = "arn:aws:iam::aws:policy/AmazonEC2ContainerRegistryReadOnly"
}

data "aws_iam_policy_document" "apprunner_ecr_doc" {
  statement {
    effect = "Allow"
    actions = [
      "ecr:GetDownloadUrlForLayer",
      "ecr:BatchCheckLayerAvailability",
      "ecr:BatchGetImage",
      "ecr:DescribeImages",
      "ecr:GetAuthorizationToken"
    ]
    resources = ["*"]
  }
}

resource "aws_iam_policy" "apprunner_ecr_policy" {
  name        = "apprunnerEcrPolicy"
  policy      = data.aws_iam_policy_document.apprunner_ecr_doc.json
}

resource "aws_iam_role_policy_attachment" "apprunner_ecr_role_policy" {
  role       = aws_iam_role.apprunner_ecr_role.name
  policy_arn = aws_iam_policy.apprunner_ecr_policy.arn
}