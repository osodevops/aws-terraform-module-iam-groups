# aws-terraform-module-iam-gropus

OSO DevOps has created a set of example groups that should be used for securing your AWS account

Specific IAM roles and groups for managing  workloads in AWS with Terraform

This Terraform module will setup the a set of default IAM user groups and the required support IAM user groups for OSO DevOps.

##Default roles

#### Role 1:  Business Owner

**Description:**  Ultimate owner of the business / CEO / Founder

Everything including billing. Owners should setup the Multi Factor Authentication. All the others users (including admin/ctos) should only login via IAM logins. Owner can set up an IAM role to share billing settings with CTO but this should be done via console.

**AWS Resource Permissions:** Everything 

**Security Recommendation** Restrict access from the workplace/VPN IP (Static IP) 

#### Role 2:  Budget Owner

**Description:**  Owner of the cloud infrastructure costs and budgets.

Everything including billing. Logs in using IAM role. Owner should setup a IAM role to share billing settings with Architect but this should be done via console.

**AWS Resource Permissions:** 

**Security Recommendation** Restrict access from the workplace/VPN IP (Static IP) 

#### Role 3:  Frontend Developer**

**Description:**  Responsible for development of user facing front-end.

Needs permission to debug issues related to frontend and setup some notifications if needed.

**AWS Resource Permissions:**

- Code commit
- Cloudfront to check and handle caching issues if needed.
- Simple Storage Service (S3)
- SQS
- SNS
- Route53

#### Role 4:  Backend Developer**

**Description:**  Responsible for development and monitoring of backend APIS.

Needs permission to debug issues related to frontend and setup some notifications if needed.

**AWS Resource Permissions:**

- Code commit
- Cloudfront to check and handle caching issues if needed.
- EC2
- Lambda
- RDS
- Cloudsearch
- Elastic Search
- Simple Storage Service (S3)
- API Gateway
- CloudTrail
- SQS
- SNS
- Key Management
- Elastic Beanstalk
- Cloud Trail
- XRay
- Cognito

## OSO DevOps roles

#### Role 1: Devops Engineer**

**Description:** A DevOps Engineer is the bridge between developer, quality, and technology teams – helping them understand each other tasks and situations so that they can work together to get the best results. 
They act as the engineering function of the team as well as the cloud architects.

**AWS Resource Permissions:**

- Code commit
- Code build
- Code deploy
- Code pipeline
- Code star
- XRay
- EC2
- Lambda
- RDS
- Cloudsearch
- Elastic Search
- Simple Storage Service (S3)
- API Gateway
- CloudTrail
- SQS
- SNS
- Key Management
- Elastic Beanstalk
- Cloud Trail
- XRay
- Cognito

#### Role 2: Support Engineer**

**Description:**  Responsible for supporting and monitoring of the AWS hosted infrastructure.

Needs permission's from the customer or the DevOps team to remove objects and work with resources not whitelisted in the IAM group policy.

**AWS Resource Permissions:**

- Code commit
- Cloudfront to check and handle caching issues if needed.
- EC2
- Lambda
- RDS
- Cloudsearch
- Elastic Search
- Simple Storage Service (S3)
- API Gateway
- CloudTrail
- SQS
- SNS
- Key Management
- Elastic Beanstalk
- Cloud Trail
- XRay
- Cognito

## Security

All the roles apart from the **Business owner** have user/group IAM policy restrictions, 
this is to ensure data does not get removed or shared with unauthorized individuals/organisations.

The restrictions used are as follows:

```HCL
statement {
    sid = "PeventModifyingSelfGroup"
    effect = "Deny"
    actions = [
      "iam:AttachGroupPolicy",
      "iam:DetachGroupPolicy"
    ]
    resources = [
      "arn:aws:iam::${var.account_id}:group/XXX",
    ]
  }
  
statement {
    sid = "PeventModifyingSelf"
    effect = "Deny"
    actions = [
      "iam:CreatePolicyVersion",
      "iam:CreatePolicy"
    ]
    resources = [
      "arn:aws:iam::${var.account_id}:policy/oso-devops-engineer-group-policy",
    ]
}
```

This snippet prevents the user from modifying the group they belong to or the underlying policy of the group. 

```HCL
statement {

    effect = "Deny"
    actions = [
      "s3:DeleteBucket"
    ]
    resources = [
      "*"
    ]
  }

  statement {

    effect = "Deny"
    actions = [
       "rds:DeleteDBCluster",
       "rds:DeleteDBInstance"
    ]
    resources = [
      "*"
    ]
  }
```

The following snippet makes sure that neither s3 nor RDS data can be lost by deleting either resource. 