### Activity 17

create 2 EC2 instance on 2 different regions and install nginx using terraform script

**Check all files in Activities/Activity17 directory**

## Step 1: Install Terraform, AWS and configure

1. Install Terraform using this link https://developer.hashicorp.com/terraform/install

2. Unzip the folder
3. Give the location of terraform folder in environment varaiables in system section
4. Install aws cli from here: https://docs.aws.amazon.com/cli/latest/userguide/getting-started-install.html

5. Download the following plugins in VScode

   - Terraform by Anton Kulikov
   - HashiCorp Terraform by HashiCrop

6. Verify the aws and terraform version using the following commands

   ```bash
   # To check Terraform version
   terraform --version

   # To check AWS Version
   aws --version
   ```

   **Sample Screenshot**

   ![alt text](/Images/version.png)

## Step 2: Create AWS Access Keys

1. Login to your AWS Account
2. Click on your Account > Security Credentials
3. Go to Access Keys section
4. click on Create **Access Key** button
5. Copy the credentials

## Step 3: Configuring aws account in to our repository

1. Create a folder in desired location
2. Create a main.tf file
3. configure the aws in the terminal
4. This will ask for access key and password > give the copied credentials from AWS

   ```bash
   aws configure
   ```

   **Sample Screenshot**

   ![alt text](/Images/aws-creds.png)

## Step 4: Creating a repository

1. Create a folder in desired location
2. Add the following code in respective files

   **main.tf file:**

   ```bash
    resource "aws_instance" "terraform_instance_1" {
        instance_type = var.instance_type
        key_name      = var.key_name
        provider      = aws.us-east-1
        ami           = var.amis[var.us-east-1]
        tags = {
            Name = "First instance in us-east-1"
        }
        user_data = base64encode(file("userdata.sh"))
    }

    resource "aws_instance" "terraform_instance_2" {
        instance_type = var.instance_type
        provider      = aws.ap-south-1
        ami           = var.amis[var.ap-south-1]
        tags = {
            Name = "First instance in us-east-2"
        }
        user_data = base64encode(file("userdata.sh"))

    }
   ```

   **vars.tf file:**

   ```bash
    variable "us-east-1" {
        default = "us-east-1"
    }

    variable "ap-south-1" {
        default = "ap-south-1"
    }

    variable "instance_type" {
        default = "t2.micro"
    }

    variable "key_name" {
        default = "first instance"
    }

    variable "amis" {
        type = map(any)
        default = {
            us-east-1  = "ami-04b70fa74e45c3917"
            ap-south-1 = "ami-0cc9838aa7ab1dce7"
        }
    }
   ```

   **providers.tf file:**

   ```bash
    provider "aws" {
        region = "us-east-1"
        alias  = "us-east-1"
    }

    provider "aws" {
        region = "ap-south-1"
        alias  = "ap-south-1"
    }
   ```

   **userdata.sh file:**

   ```bash
    #!/bin/bash
    sudo apt update -y
    sudo apt install -y nginx
    systemctl start nginx
    systemctl enable nginx
    echo "<h1>Hello World from from Terrform</h1>" > /var/www/html/index.html
   ```

3. Initialize terraform using the following command

   ```bash
   terraform init
   ```

   **Sample Screenshot**

   ![alt text](/Images/init.png)

4. Plan the resources

   ```bash
   terraform plan
   ```

   **Smaple Screenshot**

   ![alt text](/Images/plan.png)

5. Apply the changes using the following command

   ```bash
   terraform apply
   ```

   **Sample Screenshot**

   ![alt text](/Images/apply.png)

6. You can verify the instance up and running in the aws console.

   **us-east-1 (Virginia)**

   ![alt text](/Images/us-east-1.png)

   ![alt text](/Images/us-east-1-page.png)

   **ap-south-1 (Mumbai)**

   ![alt text](/Images/ap-south-1.png)

   ![alt text](/Images/ap-south-1-page.png)

7. Deleting the 2 instances

   ```bash
   terraform destroy
   ```

   **Sample Screenshot**

   ![alt text](/Images/destroy.png)
