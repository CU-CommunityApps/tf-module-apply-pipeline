# tf-module-apply-pipeline

Terraform module to create Terraform drift, plan, and apply CodePipelines.

## TO DO

- Documentation!
- Add configuration options. E.g., send notifications to existing SNS topic instead of creating a new one.

## Change Log
- 1.0.0
  - Initial release that is lacking in documentation and subtlety. 

## Variables

TBD

## Outputs

TBD

## Example Use

```

module "apply_pipeline" {
  source = "github.com/CU-CommunityApps/tf-module-apply-pipeline.git?ref=v1.0.0"  
  
  namespace = "tf-example"
  
  # production
  teams_webhook_url = "https://cornellprod.webhook.office.com/..."

  # cornell-cloud-devops-GH-user
  github_codestarconnections_connection_arn = "arn:aws:codestar-connections:us-east-1:123456789012:connection/abcdef123456"

	terraform_version      = "1.0.10"
  terraform_state_bucket = "my-tf-bucket"
	terraform_state_key    = "prod/tf-example/resources/terraform.state"
	github_repo = "CU-CommunityApps/tf-example"
	git_branch  = "main"
	environment = "dev"
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