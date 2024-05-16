# Creating an S3 Bucket in Using Terraform

## Save AWS Access Keys for Terraform Admin Account

1. Create an AWS credentials file so that Terraform can get the programmatic credentials for the AWS administrator pushing configs via Terraform. 

`% mkdir ~/.aws/credentials`

2. Navigate to `https://console.aws.amazon.com`

3. Navigate to `IAM` and search for **Access Keys**. Click on **Manage Access Keys for *admin user***

4. Navigate to the `Access keys` menu to generate the `aws_access_key_id` and `aws_secret_access_key`. Copy these keys. 

5. Go back to terminal and edit the `~/.aws/credentials` file to paste the keys here:

```
[default]
aws_access_key_id = <access_key_id_here>
aws_secret_access_key = <secret_access_key_here>
```
6. Save the file.

## Use Terraform to Create an S3 bucket

1. Create a directory for the project. I created one called `Configure_S3_Bucket_Terraform`

2. Add a file called `main.tf`

```
% mkdir S3_Configure_Bucket_Terraform
% touch main.tf
```

3. Paste the following code into `main.tf` and replace `<your-name>` with your name after the `bucket` [argument]('https://developer.hashicorp.com/terraform/language/resources/syntax'):

```
provider "aws" {
    region = "us-east-2"
}

resource "aws_s3_bucket" "first_bucket" {
    bucket = "<your-name>-first-bucket"
}
```

4. Initialize Terraform from your directory:

`% terraform init`

Output:

```
(venv) micvu@MICVU-M-33JC Configure_S3_Bucket_Terraform % terraform init

Initializing the backend...

Initializing provider plugins...
- Finding latest version of hashicorp/aws...
- Installing hashicorp/aws v5.49.0...
- Installed hashicorp/aws v5.49.0 (signed by HashiCorp)

Terraform has created a lock file .terraform.lock.hcl to record the provider
selections it made above. Include this file in your version control repository
so that Terraform can guarantee to make the same selections by default when
you run "terraform init" in the future.

Terraform has been successfully initialized!

You may now begin working with Terraform. Try running "terraform plan" to see
any changes that are required for your infrastructure. All Terraform commands
should now work.

If you ever set or change modules or backend configuration for Terraform,
rerun this command to reinitialize your working directory. If you forget, other
commands will detect it and remind you to do so if necessary.
```

5. Apply your Terraform configuration:

`% terraform apply`

6. Type `yes` and hit enter

```
venv) micvu@MICVU-M-33JC Configure_S3_Bucket_Terraform % terraform apply

Terraform used the selected providers to generate the following execution plan. Resource
actions are indicated with the following symbols:
  + create

Terraform will perform the following actions:

  # aws_s3_bucket.first_bucket will be created
  + resource "aws_s3_bucket" "first_bucket" {
      + acceleration_status         = (known after apply)
      + acl                         = (known after apply)
      + arn                         = (known after apply)
      + bucket                      = "mikes-first-bucket"
      + bucket_domain_name          = (known after apply)
      + bucket_prefix               = (known after apply)
      + bucket_regional_domain_name = (known after apply)
      + force_destroy               = false
      + hosted_zone_id              = (known after apply)
      + id                          = (known after apply)
      + object_lock_enabled         = (known after apply)
      + policy                      = (known after apply)
      + region                      = (known after apply)
      + request_payer               = (known after apply)
      + tags_all                    = (known after apply)
      + website_domain              = (known after apply)
      + website_endpoint            = (known after apply)
    }

Plan: 1 to add, 0 to change, 0 to destroy.

Do you want to perform these actions?
  Terraform will perform the actions described above.
  Only 'yes' will be accepted to approve.

  Enter a value: yes

  aws_s3_bucket.first_bucket: Creating...
aws_s3_bucket.first_bucket: Creation complete after 2s [id=vus-first-bucket]

Apply complete! Resources: 1 added, 0 changed, 0 destroyed.

```

## Verify Bucket Creation

1. Navigate to the Buckets menu of your AWS console. 

2. Verify that your Bucket was configured:

![Bucket Verification](https://github.com/mikeovu/Learn-Terraform/blob/1cadac93df685f9c340d9a79532a326b911271dc/Configure_S3_Bucket_Terraform/Images/bucket_verification.png)

## Terraform Destroy

Run the `% terraform destroy` command

```
aws_s3_bucket.first_bucket: Refreshing state... [id=vus-first-bucket]

Terraform used the selected providers to generate the following execution
plan. Resource actions are indicated with the following symbols:
  - destroy

Terraform will perform the following actions:

  # aws_s3_bucket.first_bucket will be destroyed
  - resource "aws_s3_bucket" "first_bucket" {
      - arn                         = "arn:aws:s3:::vus-first-bucket" -> null
      - bucket                      = "vus-first-bucket" -> null
      - bucket_domain_name          = "vus-first-bucket.s3.amazonaws.com" -> null
      - bucket_regional_domain_name = "vus-first-bucket.s3.us-east-2.amazonaws.com" -> null
      - force_destroy               = false -> null
      - hosted_zone_id              = "Z2O1EMRO9K5GLX" -> null
      - id                          = "vus-first-bucket" -> null
      - object_lock_enabled         = false -> null
      - region                      = "us-east-2" -> null
      - request_payer               = "BucketOwner" -> null
      - tags                        = {} -> null
      - tags_all                    = {} -> null
        # (3 unchanged attributes hidden)

      - grant {
          - id          = "32d5a6ff5e649dc794f25ddc46a8ef24c48bc2f7f85318544f20829b0721b334" -> null
          - permissions = [
              - "FULL_CONTROL",
            ] -> null
          - type        = "CanonicalUser" -> null
            # (1 unchanged attribute hidden)
        }

      - server_side_encryption_configuration {
          - rule {
              - bucket_key_enabled = false -> null

              - apply_server_side_encryption_by_default {
                  - sse_algorithm     = "AES256" -> null
                    # (1 unchanged attribute hidden)
                }
            }
        }

      - versioning {
          - enabled    = false -> null
          - mfa_delete = false -> null
        }
    }

Plan: 0 to add, 0 to change, 1 to destroy.

Do you really want to destroy all resources?
  Terraform will destroy all your managed infrastructure, as shown above.
  There is no undo. Only 'yes' will be accepted to confirm.

  Enter a value: yes

aws_s3_bucket.first_bucket: Destroying... [id=vus-first-bucket]
aws_s3_bucket.first_bucket: Destruction complete after 0s

Destroy complete! Resources: 1 destroyed.
```
