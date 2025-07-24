resource "aws_instance" "bastion" {
    ami = var.ami_id["al2023"]
    instance_type = "t2.micro"
    iam_instance_profile = var.profile
    subnet_id = var.subnet_id
    key_name = var.key_name
    vpc_security_group_ids = var.sg_id
    tags = {
        Name: var.ec2_name
    }
}