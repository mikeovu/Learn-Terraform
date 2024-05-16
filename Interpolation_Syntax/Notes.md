# Interpolation Syntax

## Useful resource output

Once a resource is created, it returns attributes. Examples of attributes for AWS S3:

- `id` - Name of the bucket

- `arn` - ARN of the bucket. Will be format `arn:aws:s3:::bucketname`

- `region` - AWS region this bucket resides in.

Reference the **Attribute Reference** section of the [S3 Registry Documentation]('https://registry.terraform.io/providers/hashicorp/aws/latest/docs/resources/s3_bucket.html') for more details.

## Output attribute

```
resource "aws_vpc" "my_vpc" {
    cidr_block = "10.0.0.0/16"
}

resource "aws_security_group" "my_security_group" {
    vpc_id = aws_vpc.my_vpc.id
    name = "Example security group"
}
```

The format for using an output attribute from a resource is `<resource_type>.<resource_identifier>.<attribute_name>`. 

In the VPC id example, we are getting the output from an `aws_vpc` resource type, with the identifier name `my_vpc`, and we want to get the id attribute value. 

Thus, we end up with `aws_vpc.my_vpc.id`. 

## Security group rule

```
resource "aws_security_group" "my_security_group" {
    vpc_id = aws_vpc.my_vpc.id
    name = "Example security group"
}

resource "aws_security_group_rule" "tls_in" {
    protocol = "tcp"
    security_group_id = aws_security_group.my_security_group.id
    from_port = 443
    to_port = 443
    type = "ingress"
    cidr_blocks = ["0.0.0.0/0"]
}
```

This rule allows ingress traffic on port 443. 

In the `aws_security_group_rule`, we need to reference the id of the security group that we want to put this rule in. 

We can use the same technique as we did when we referenced the id of the VPC:


- It will start with the type of resource we want to reference, `aws_security_group`.

- Next, we use the identifier to specify which instance of the security group we want to use, which is `my_security_group`.

- We use the attribute of that property we want to use, which is id.

This leads us to build the expression `aws_security_group.my_security_group.id` which we can use for the value of the property `security_group_id` inside the `aws_security_group_rule` resource.

## Adding a New Security Group

Terraform can create multiple security groups in parallel.

```
resource "aws_security_group_rule" "http_in" {
    protocol = "tcp"
    security_group_id = aws_security_group.my_security_group.id
    from_port = 80
    to_port = 80
    type = "ingress"
    cidr_blocks = ["0.0.0.0/0"]
}
```
- This security group allows inbound traffic on port 80 (http)




