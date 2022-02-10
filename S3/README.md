

# What is S3
S3 means Simple Storage Service. It is a highly available and very cost effective service.

Amazon S3 stores Objects, they differ from files in a way.... {need extra reading}

S3 uses Buckets for storage. These buckets exist in different AWS regions, such as Ireland or Frankfurt. Stored data is replicated between multiple data centres. Behind the scenes, one object may be stored in one data region but will actually be duplicated multiple times.



S3 can be used for disaster recovery. With S3 we can use CRUD, which stands for the actions: Create bucket/object, read, update and delete.

![dr](https://user-images.githubusercontent.com/98178943/152986900-5684a71b-9f22-4cf1-9b33-47e8334a476b.png)
The diagram above shows the steps throughout disaster recovery. If throughout any point an instance fails, objects stored can be accessed from other Buckets.

**From the diagram, from the localhost to AWS EC2:**
- We need the .pem to be able to access our EC2

**From the AWS EC2 to our AWS S3:**
- We need AWSCLI and its dependencies
- We also need AWS Access and Security keys

**AWS S3 has various storage classes:**
- Standard - Access data at anytime (higher cost)
- Glacial - For infrequent data access (cheaper), ideal for long term storage and can only be accessed from time to time.

**CRUD: Create/Read/Update/Delete:**
- A CRUD application performs all these functions
- An example would be online banking:
```
- New accounts can be made, status of existing accounts balances can be checked.
- You can make transactions and update your info etc.
```

To access S3 and to effectively back up and recover objects we need to have access to our AWS ACCESS KEY and SECRET KEY.

## AWS Command Line Interface (AWSCLI)
---------
AWSCLI is used to command multiple AWS services and we can access S3 through this.
### Steps:
- SSH into your instance
- install AWSCLI python 3 dependencies: `sudo apt install python3-pip`
- `sudo apt install python3.7-minimal`
- Set alias for python: `alias python=python3.7`
- `sudo pip3 install awscli`
- Enter `aws configure` to enter your access and security keys:
```
AWS Access Key ID [None]: 
AWS Secret Access Key [None]:
Default region name [None]: eu-west-1
Default output format [None]: json
```
- Enter `aws s3 ls` to check that you have the correct buckets available.

## Applying CRUD to Buckets
-------------------
Commands list: on terminal:
```
make bucket - `aws mb s3://[name]`
remove bucket - `aws s3 rb s3://[name]`
remove files - `aws s3 rm s3://[name]/[file-name]
```
### We can code these commands this using python boto3
--------------------
- Enter `pip3 install boto3`
- Create a python file `sudo nano file_name.py`

```
#!/usr/bin/env python3

import boto3
bucket_name = "eng103a-yacob-boto3"
location = {'LocationConstraint': "eu-west-1"}

# creates bucket
s3 = boto3.resource('s3')
s3.create_bucket(Bucket=bucket_name, CreateBucketConfiguration=location)

# downloads file
s3 = boto3.client('s3')
s3.download_file('eng103a-name-devops', 'file.txt')

# delete object in bucket

s3 = boto3.resource('s3')
s3.Object('eng103a-name-devops', 'test.txt').delete()

# delete object

client = boto3.client('s3', region_name='eu-west-1')
bucket_name = 'eng103a-name-devops'
client.delete_bucket(Bucket=bucket_name)

```

To fully automate the process and make it responsive to user input we can implement a while loop with if statement blocks:

```
#!/usr/bin/env python3
import boto3

location = {'LocationConstraint': "eu-west-1"}
s3 = boto3.resource('s3')

bucket_name = input("Enter the bucket name, please ensure there are no underscore (e.g. hello_world):\n")

while True:
    user_input = input("Type mb to make a bucket, rb to remove/delete a bucket, df to delete a file, upload to upload "
                       "a file, dl to download a file or enter exit to abort script:\n")

    if user_input == "mb":
        s3.create_bucket(Bucket=bucket_name, CreateBucketConfiguration=location)
    elif user_input == "rb":
        s3.Bucket(bucket_name).delete()
    elif user_input == "df":
        file_name = input("Please enter file name:\n")
        s3.Object(bucket_name, file_name).delete()
    elif user_input == "upload":
        file_name = input("What is the name of the file that you would like to upload?\n")
        upload_user_input = input("Do you want to change destination name? Type yes or no:\n")
        if upload_user_input in ('y', 'Y', 'Yes', 'yes', 'ye', 'yy'):
            destination_file_name = input("What is the destination file name?\n")
            s3.Bucket(bucket_name).upload_file(file_name, destination_file_name)
        else:
            s3.Bucket(bucket_name).upload_file(file_name, file_name)
    elif user_input == "dl":
        file_name = input("Enter the name of the file you want to download:\n")
        upload_user_input = input("Do you want to change destination name? Type yes or no:\n")
        if upload_user_input in ('y', 'Y', 'Yes', 'yes', 'ye', 'yy'):
            destination_file_name = input("What is the destination file name?\n")
            s3.Bucket(bucket_name).download_file(file_name, destination_file_name)
        else:
            s3.Bucket(bucket_name).download_file(file_name, file_name)
    elif user_input == "exit":
        print("Goodbye!")
        break
    else:
        print("Please enter one of the options:", "\n")

```

# Auto scaling group and Load Balancing

![Autoscale diagram](https://user-images.githubusercontent.com/98178943/153212600-fe481259-68e0-411d-a1f9-1172c4caa6cf.png)

Auto scaling - Automatically adjusts the amount of computational resources based on the server load.

Load balancing - Distributes the traffic between EC2 instances so that no one instance gets overwhelmed

**To create an auto scaling group there are several steps we need to follow:**

## Creating a Launch Template
- Make sure you have an up to date AMI with which you want to use otherwise you'll have to create a new application

The steps are:
- Select `Launch Templates` under `Instances` in the left tab
- Select `Create Launch Template` 
- Fill in `Launch template name and description` with appropriate names
- Under `Application and OS Images (Amazon machine Image)`, select your AMI or create new ubuntu machine.
- `Instance type` is t2.micro, depending on your needs
- `Key pair (login)` select your existing pair
- `Network settings` select or create a security group, with the correct VPC
- Leave configure storage unless it needs changing
- Under `Resource tags` enter the key and value fields as appropriate and then under `Resource types` select Instances, Volumes and Network interfaces.
- Under `Advanced details`, select `Enable resource-based IPV4 (A record) DNS requests`. Under `User data` enter the commands for the instance you want to run. In this case:
```
#!/bin/bash
sudo apt update -y && sudo apt upgrade -y
sudo su ubuntu
source /home/ubuntu/.bashrc
cd /home/ubuntu/app && screen -d -m npm start

(Your file directory may differ)
```

## Creating an Auto Scaling Group
------------------
- Head to `Auto Scaling Groups`, enter an appropriate name and select the launch template you'd like to use.
- Under `Network` select the correct VPC and what AZ you'd like to use.
- Under `load balancer` select the appropriate load balancer type, select the appropriate name and enter the correct scheme (internal vs Internet-facing). 
- Create a listener group with the appropriate name
- Group size - set the desired, minimum and maximum capacity:
```
Desired capacity - Desired number of instances
Minimum capacity - Minimum number of instances 
Maximum capacity - Max number of instances.
```
Create your ASG and depending on the number of AZ you have (in my case three), you'll see those number of instances in your dashboard. 