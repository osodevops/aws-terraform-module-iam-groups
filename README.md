[![OSO DevOps][logo]](https://osodevops.io)

# aws-terraform-module-iam-gropus

OSO DevOps has created a set of example groups that should be used for securing your AWS account

Specific IAM roles and groups for managing workloads in AWS with Terraform

This Terraform module will setup a set of default IAM user groups and the required support IAM user groups for OSO DevOps. 

This project is part of our open source DevSecOps adoption approach. 

It's 100% Open Source and licensed under the [APACHE2](LICENSE).

## Usage

Include this repository as a module in your existing terraform code:
```hcl
module "iam-groups" {
  source                      = "git::ssh://git@github.com/osodevops/aws-terraform-module-iam-groups.git"
  region                      = "eu-west-1"
  account_id                  = "1122334455"
  }
}
```

## Inputs

| Name | Description | Type | Default | Required |
|------|-------------|:----:|:-----:|:-----:|
| region | The AWS region where your infrastructure is hosted | string | - | yes |
| account_id | The AWS account id number | string | - | yes |

## Understanding the IAM Groups

#### Role 1:  Business Owner

**Description:** Ultimate owner of the business / CEO / Founder

Everything including billing. Owners should setup the Multi Factor Authentication. All the others users (including admin/ctos) should only login via IAM logins. Owner can set up an IAM role to share billing settings with CTO but this should be done via console.

**AWS Resource Permissions:** Everything 

**Security Recommendation** Restrict access from the workplace/VPN IP (Static IP) 

#### Role 2: Budget Owner

**Description:** Owner of the cloud infrastructure costs and budgets.

Everything including billing. Logs in using IAM role. Owner should setup a IAM role to share billing settings with Architect but this should be done via console.

**AWS Resource Permissions:**

**Security Recommendation** Restrict access from the workplace/VPN IP (Static IP) 

#### Role 3:  Frontend Developer

**Description:**  Responsible for development of user facing front-end.

Needs permission to debug issues related to frontend and setup some notifications if needed.

**AWS Resource Permissions:**

- Code commit
- Cloudfront to check and handle caching issues if needed.
- Simple Storage Service (S3)
- SQS
- SNS
- Route53

#### Role 4: Backend Developer

**Description:** Responsible for development and monitoring of backend APIS.

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

#### Role 1: Devops Engineer

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

#### Role 2: Support Engineer

**Description:** Responsible for supporting and monitoring of the AWS hosted infrastructure.

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
 
## Help

**Got a question?**

File a GitHub [issue](https://github.com/osodevops/aws-terraform-module-iam-groups/issues), send us an [email][email] or tweet us [twitter][twitter].

## Contributing

### Bug Reports & Feature Requests

Please use the [issue tracker](https://github.com/osodevops/aws-terraform-module-iam-groups/issues) to report any bugs or file feature requests.

### Developing

If you are interested in being a contributor and want to get involved in developing this project or help out with our other projects, we would love to hear from you! Shoot us an [email][email].

In general, PRs are welcome. We follow the typical "fork-and-pull" Git workflow.

 1. **Fork** the repo on GitHub
 2. **Clone** the project to your own machine
 3. **Commit** changes to your own branch
 4. **Push** your work back up to your fork
 5. Submit a **Pull Request** so that we can review your changes

**NOTE:** Be sure to merge the latest changes from "upstream" before making a pull request!

## Copyrights

Copyright © 2018-2019 [OSO DevOps](https://osodevops.io)

## License 

[![License](https://img.shields.io/badge/License-Apache%202.0-blue.svg)](https://opensource.org/licenses/Apache-2.0) 

See [LICENSE](LICENSE) for full details.

    Licensed to the Apache Software Foundation (ASF) under one
    or more contributor license agreements.  See the NOTICE file
    distributed with this work for additional information
    regarding copyright ownership.  The ASF licenses this file
    to you under the Apache License, Version 2.0 (the
    "License"); you may not use this file except in compliance
    with the License.  You may obtain a copy of the License at

      https://www.apache.org/licenses/LICENSE-2.0

    Unless required by applicable law or agreed to in writing,
    software distributed under the License is distributed on an
    "AS IS" BASIS, WITHOUT WARRANTIES OR CONDITIONS OF ANY
    KIND, either express or implied.  See the License for the
    specific language governing permissions and limitations
    under the License.

## Trademarks

All other trademarks referenced herein are the property of their respective owners.

## About

[![OSO DevOps][logo]][website]

We are a cloud consultancy specialising in transforming technology organisations through DevOps practices. We help organisations accelerate their capabilities for application delivery and minimize the time-to-market for software-driven innovation. 

Check out [our other projects][github], [follow us on twitter][twitter], or [hire us][hire] to help with your cloud strategy and implementation.

  [logo]: https://osodevops.io/assets/images/logo-purple-b3af53cc.svg
  [website]: https://osodevops.io/
  [github]: https://github.com/orgs/osodevops/
  [hire]: https://osodevops.io/contact/
  [linkedin]: https://www.linkedin.com/company/oso-devops
  [twitter]: https://twitter.com/osodevops
  [email]: https://www.osodevops.io/contact/