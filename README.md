# tf-module-apply-pipeline

Terraform module to create Terraform drift, plan, and apply CodePipelines.

## Resources Created

- CodePipeline to run Terraform plan/apply operations. This pipeline contains a manual review step.
- CodePipeline to run drift check on target resources. This pipeline is scheduled with a cron expression.
- CodeBuld projects to support the CodePipelines
- IAM Policies and Roles to support the CodePipelines
- Notifications of Pipeline/Build status sent to Teams

## TO DO

- Integrate the full script from `tf-plan.sh` into `buildspec.plan.tmpl.yml`. This script stops the pipeline when there are no changes to be applied.
- Add configuration options. E.g., send notifications to existing SNS topic instead of creating a new one.
- More documentation

## Change Log

### 3.0.0
- add output consisting of the ARN of SNS topic where CodePipeline and CodeBuild notifications are sent
- remove use of `tf-module-sns-teams-relay` module
- add tags to all resources that can be tagged

### 2.0.0
- added TF_LOGs configuration option
- added `iam:GetPolicy` and `iam:GetPolicyVersion` privileges for the policies passed in as `resource_plan_policy_arns` and `resource_apply_policy_arns`
- bump `tf-module-sns-teams-relay` version to 1.1.0
- removed unused `environment` variable
- rename `build_cron` variable to `drift_cron`
- added minimal documentation

### 1.0.0
- Initial release that is lacking in documentation and subtlety

## Variables

See descriptions in `variables.tf`.

## Outputs

None.

## Example Use

```

module "apply_pipeline" {
  source = "github.com/CU-CommunityApps/tf-module-apply-pipeline.git?ref=v1.0.0"  
  
  namespace = "tf-example"
  
  # cornell-cloud-devops-GH-user
  github_codestarconnections_connection_arn = "arn:aws:codestar-connections:us-east-1:123456789012:connection/abcdef123456"

  terraform_version      = "1.0.10"
  terraform_state_bucket = "my-tf-bucket"
  terraform_state_key    = "prod/tf-example/resources/terraform.state"
  github_repo = "CU-CommunityApps/tf-example"
  git_branch  = "main"
  resource_plan_policy_arns = [
    "arn:aws:iam::123456789012:policy/tf-example-plan-privs"
  ]
  resource_apply_policy_arns = [
	"arn:aws:iam::123456789012:policy/tf-example-apply-privs"
  ]
	global_tags = {
      Terraform = "true"
      Environment = "dev"
      Application = "tf-example"
  }
}

```