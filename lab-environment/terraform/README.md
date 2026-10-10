# Terraform — AWS IAM Lab Sandbox

See `../2-AWS-Terraform-Sandbox.md` for the full walkthrough. This directory is the real, CI-validated version of that guide's `main.tf`.

```bash
terraform init
terraform validate
terraform plan    # review before ever applying
terraform apply   # sandbox account ONLY
terraform destroy # always clean up
```

CI (`.github/workflows/terraform-validate.yml`) runs `terraform fmt -check` and `terraform validate` on every change to this directory — it never runs `apply`.
