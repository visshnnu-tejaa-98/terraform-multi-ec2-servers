

resource "aws_instance" "terraform_instance_1" {
  instance_type = var.instance_type
  key_name      = var.key_name
  provider      = aws.us-east-1
  ami           = var.amis[var.us-east-1]
  tags = {
    Name = "First instance in us-east-1"
  }
  user_data_base64 = base64encode(file("userdata.sh"))
}

resource "aws_instance" "terraform_instance_2" {
  instance_type = var.instance_type
  provider      = aws.ap-south-1
  ami           = var.amis[var.ap-south-1]
  tags = {
    Name = "First instance in us-east-2"
  }
  user_data_base64 = base64encode(file("userdata.sh"))

}