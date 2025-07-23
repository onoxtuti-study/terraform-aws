resource "aws_instance" "bastion" {
    ami = var.ami_id["al2023"]
    instance_type = "t2.micro"
    iam_instance_profile = var.profile
    subnet_id = var.subnet_id
    key_name = var.key_name
    security_groups = var.sg_id
    tags = {
        Name: var.ec2_name
    }
}