data "aws_iam_policy_document" "no_access" {

  statement {
    sid = "DenyAllActions"
    effect = "Deny"
    actions = [
      "acm:*",
      "artifact:*",
      "apigateway:*",
      "application-autoscaling:*",
      "appmesh:*",
      "appstream:*",
      "athena:*",
      "autoscaling:*",
      "autoscaling-plans:*",
      "connect:*",
      "clouddirectory:*",
      "cloud9:*",
      "cloudformation:*",
      "cloudfront:*",
      "cloudhsm:*",
      "cloudsearch:*",
      "cloudtrail:*",
      "cloudwatch:*",
      "codebuild:*",
      "codecommit:*",
      "codedeploy:*",
      "codepipeline:*",
      "codestar:*",
      "cognito:*",
      "cognito-identity:*",
      "cognito-idp:*",
      "cognito-sync:*",
      "config:*",
      "batch:*",
      "datapipeline:*",
      "discovery:*",
      "dlm:*",
      "dms:*",
      "ds:*",
      "directconnect:*",
      "dynamodb:*",
      "dax:*",
      "ec2:*",
      "ec2messages:*",
      "ecr:*",
      "ecs:*",
      "eks:*",
      "elasticfilesystem:*",
      "elasticloadbalancing:*",
      "elasticmapreduce:*",
      "elasticache:*",
      "es:*",
      "events:*",
      "execute-api:*",
      "firehose:*",
      "iam:*",
      "inspector:*",
      "glacier:*",
      "glue:*",
      "guardduty:*",
      "health:*",
      "importexport:*",
      "inspector:*",
      "kinesis:*",
      "kms:*",
      "lambda:*",
      "lightsail:*",
      "logs:*",
      "maice:*",
      "mgh:*",
      "mq:*",
      "pricing:*",
      "rds:*",
      "redshift:*",
      "resource-groups:*",
      "route53:*",
      "route53domains:*",
      "s3:*",
      "ses:*",
      "secretsmanager:*",
      "servicediscovery:*",
      "shield:*",
      "sdb:*",
      "sso:*",
      "sns:*",
      "sqs:*",
      "states:*",
      "sts:*",
      "swf:*",
      "storagegateway:*",
      "tag:*",
      "translate:*",
      "trustedadvisor:*",
      "waf:*",
      "waf-regional:*",
      "xray:*",
      "aws-marketplace:*",
      "aws-marketplace-management:*",
    ]
    resources = [
      "*"
    ]
  }
}
