# Terraform Provider 

Terraform creates the `.terraform.lock.hcl` file during the `terraform init` process to record the version of all providers used. This is so when `terraform init` is run again, Terraform can select exactly the same versions of providers that were used when the project was first run. This is important for repeatability. 

**Warning Message when `terraform init` is run**:

```
Terraform has created a lock file .terraform.lock.hcl to record the provider
selections it made above. Include this file in your version control repository
so that Terraform can guarantee to make the same selections by default when
you run "terraform init" in the future.
```

It can be useful to control the version of the provider that Terraform selects when init is first run. 

For example, some of your code may only work with v3 of a provider because there is a breaking change in v4. 

By committing the .terraform.lock.hcl file as suggested in the message, you will guarantee that the version of the provider you used when you set up this project will always be used.

## Example of Selecting Specific Version:

```
provider "aws" {
  region  = "us-east-2"
}

terraform {
  required_providers {
    aws = {
      version = "~> 3.46"
    }
  }
}
```

In the Terraform block above, we have defined a required_providers block. This required provider block allows us to specify extra properties for each of the providers we are using in the project.

Under required providers, we open an AWS block. There, we specify a version constraint for the AWS provider.

The version constraint `∼> 3.46` is used by Terraform when there is no `.terraform.lock.hcl` present. 

This constraint means that **any version greater than or equal to 3.46 but less than 4.0 is allowed**. In normal operation, you should not need to worry about version constraints as long as you commit the lock file.